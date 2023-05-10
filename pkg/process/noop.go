package process

import (
	"context"

	"github.com/parca-dev/parca-agent/pkg/objectfile"
)

type NoopDebuginfoManager struct{}

func (NoopDebuginfoManager) ExtractOrFindDebugInfo(context.Context, string, *objectfile.ObjectFile) error {
	return nil
}

func (NoopDebuginfoManager) UploadWithRetry(context.Context, *objectfile.ObjectFile) error {
	return nil
}
func (NoopDebuginfoManager) Upload(context.Context, *objectfile.ObjectFile) error { return nil }
func (NoopDebuginfoManager) Close() error                                         { return nil }
