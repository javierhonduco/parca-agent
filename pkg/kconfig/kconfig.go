// Copyright 2022 The Parca Authors
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package kconfig

import (
	"bufio"
	"compress/gzip"
	"fmt"
	"os"
	"strings"
)

const (
	ContainerCgroupPath = "/proc/1/cgroup"
	StackUnwinder       = "CONFIG_UNWINDER_FRAME_POINTER" //Add either/or for the stack unwinding options
)

var ebpfCheckOptions = []string{
	"CONFIG_BPF",
	"CONFIG_BPF_SYSCALL",
	"CONFIG_HAVE_EBPF_JIT",
	"CONFIG_BPF_JIT",
	"CONFIG_BPF_JIT_ALWAYS_ON",
	"CONFIG_BPF_EVENTS",
}

func IsBPFEnabled(configFiles []string) (bool, error) {
	var err error
	var kernelConfig = make(map[string]string)

	for _, configFile := range configFiles {
		kernelConfig, err = getConfig(configFile)
		if err != nil {
			return false, fmt.Errorf("could not get kernel config:%s", err)
		}
	}

	for _, option := range ebpfCheckOptions {
		value, found := kernelConfig[option]
		if !found {
			return false, fmt.Errorf("kernel config required for ebpf not found, Config Option:%s", option)
		}

		if value != "y" && value != "m" {
			return false, fmt.Errorf("kernel config required for ebpf is disabled, Config Option:%s", option)
		}
	}
	return true, nil
}

func IsStackUnwindingEnabled(configFiles []string) (bool, error) {
	var err error
	var kernelConfig = make(map[string]string)

	for _, configFile := range configFiles {
		kernelConfig, err = getConfig(configFile)
		if err != nil {
			return false, fmt.Errorf("could not get kernel config:%s", err)
		}
	}

	value, found := kernelConfig[StackUnwinder]
	if !found {
		return false, fmt.Errorf("kernel config required for frame pointer stack unwinder not found, Config Option:%s", StackUnwinder)
	}

	if value != "y" {
		return false, fmt.Errorf("kernel config for frame pointer stack unwinder is disabled, Config Option:%s", StackUnwinder)
	}
	return true, nil
}

func getConfig(configFile string) (map[string]string, error) {
	var found bool

	kernelConfig := make(map[string]string)

	uname, err := UnameRelease()
	if err != nil {
		return kernelConfig, err
	}

	bootConfigPath := fmt.Sprintf("/boot/config-%s", uname)

	if strings.Contains(configFile, ".gz") {
		kernelConfig, err = readConfigFromProc(configFile)
	} else if strings.Contains(configFile, bootConfigPath) {
		kernelConfig, err = readConfigFromBoot(bootConfigPath)
	} else {
		kernelConfig, err = readConfigFromBoot(configFile)
	}

	if len(kernelConfig) > 0 && err == nil {
		found = true
	}

	//TODO: better error handling

	if !found {
		return nil, fmt.Errorf("kernel config not found")
	}

	return kernelConfig, nil
}

func readConfigFromBoot(filename string) (map[string]string, error) {
	kernelConfig := make(map[string]string)

	file, err := os.Open(filename)
	if err != nil {
		return kernelConfig, err
	}
	defer file.Close()

	s := bufio.NewScanner(file)
	if err = parse(s, kernelConfig); err != nil {
		return kernelConfig, err
	}
	return kernelConfig, nil
}

func readConfigFromProc(filename string) (map[string]string, error) {
	kernelConfig := make(map[string]string)

	file, err := os.Open(filename)
	if err != nil {
		return kernelConfig, err
	}

	zreader, err := gzip.NewReader(file)
	if err != nil {
		return kernelConfig, err
	}
	defer file.Close()
	defer zreader.Close()

	s := bufio.NewScanner(zreader)
	if err = parse(s, kernelConfig); err != nil {
		return kernelConfig, err
	}

	return kernelConfig, nil
}

// Returns true is the process is running in a container
// TODO: Add a container detection via Sched to cover more scenarios
// https://man7.org/linux/man-pages/man7/sched.7.html
func IsInContainer() (bool, error) {
	var f *os.File
	var err error
	var i int
	f, err = os.Open(ContainerCgroupPath)
	if err != nil {
		return false, err
	}
	defer f.Close()
	b := make([]byte, 1024)
	i, err = f.Read(b)
	if err != nil {
		return false, err
	}
	switch {
	// CGROUP V1 docker container
	case strings.Contains(string(b[:i]), "cpuset:/docker"):
		return true, nil
	// CGROUP V2 docker container
	case strings.Contains(string(b[:i]), "0::/\n"):
		return true, nil
	// k8s container
	case strings.Contains(string(b[:i]), "cpuset:/kubepods"):
		return true, nil
	}

	return false, nil
}
