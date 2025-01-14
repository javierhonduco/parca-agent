// Copyright 2022-2023 The Parca Authors
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
//

package debuginfo

import (
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
)

const (
	lvSuccess = "success"
	lvFail    = "fail"
	lvShared  = "shared"
)

type metrics struct {
	extract                   *prometheus.CounterVec
	extractDuration           prometheus.Histogram
	find                      *prometheus.CounterVec
	findDuration              prometheus.Histogram
	uploadRequests            prometheus.Counter
	uploadAttempts            prometheus.Counter
	uploadRetry               prometheus.Counter
	uploadInflight            prometheus.Gauge
	uploadRequestWaitDuration prometheus.Histogram
	upload                    *prometheus.CounterVec
	uploadDuration            prometheus.Histogram
}

func newMetrics(reg prometheus.Registerer) *metrics {
	m := &metrics{
		extract: promauto.With(reg).NewCounterVec(prometheus.CounterOpts{
			Name: "parca_agent_debuginfo_extract_total",
			Help: "Total number of debug information extracted.",
		}, []string{"result"}),
		extractDuration: promauto.With(reg).NewHistogram(prometheus.HistogramOpts{
			Name:    "parca_agent_debuginfo_extract_duration_seconds",
			Help:    "Total time spent extracting debuginfo.",
			Buckets: []float64{0.0001, 0.001, 0.01, 0.1, 0.3, 0.6, 1, 3, 6, 9, 20, 60, 90, 120},
		}),
		find: promauto.With(reg).NewCounterVec(prometheus.CounterOpts{
			Name: "parca_agent_debuginfo_find_total",
			Help: "Total number of debug information found.",
		}, []string{"result"}),
		findDuration: promauto.With(reg).NewHistogram(prometheus.HistogramOpts{
			Name:    "parca_agent_debuginfo_find_duration_seconds",
			Help:    "Total time spent finding debuginfo.",
			Buckets: []float64{0.0001, 0.001, 0.01, 0.1, 0.3, 0.6, 1, 3, 6, 9, 20, 60, 90, 120},
		}),
		uploadAttempts: promauto.With(reg).NewCounter(prometheus.CounterOpts{
			Name: "parca_agent_debuginfo_upload_attempts_total",
			Help: "Total number of attempts to upload debuginfo.",
		}),
		uploadRequests: promauto.With(reg).NewCounter(prometheus.CounterOpts{
			Name: "parca_agent_debuginfo_upload_requests_total",
			Help: "Total number of requests to upload debuginfo.",
		}),
		uploadRetry: promauto.With(reg).NewCounter(prometheus.CounterOpts{
			Name: "parca_agent_debuginfo_upload_retry_total",
			Help: "Total number of retries to upload debuginfo.",
		}),
		uploadInflight: promauto.With(reg).NewGauge(prometheus.GaugeOpts{
			Name: "parca_agent_debuginfo_upload_inflight_requests",
			Help: "Total number of debuginfo uploads in flight.",
		}),
		uploadRequestWaitDuration: promauto.With(reg).NewHistogram(prometheus.HistogramOpts{
			Name:    "parca_agent_debuginfo_upload_request_wait_duration_seconds",
			Help:    "Total time spent waiting for upload.",
			Buckets: []float64{0.0001, 0.001, 0.01, 0.1, 0.3, 0.6, 1, 3, 6, 9, 20, 60, 90, 120},
		}),
		upload: promauto.With(reg).NewCounterVec(prometheus.CounterOpts{
			Name: "parca_agent_debuginfo_upload_total",
			Help: "Number of debuginfo successfully uploaded",
		}, []string{"result"}),
		uploadDuration: promauto.With(reg).NewHistogram(prometheus.HistogramOpts{
			Name:    "parca_agent_debuginfo_upload_duration_seconds",
			Help:    "Total time spent loading cache.",
			Buckets: []float64{0.001, 0.01, 0.1, 0.3, 0.6, 1, 3, 6, 9, 20, 30, 60, 90, 120},
		}),
	}
	m.extract.WithLabelValues(lvSuccess)
	m.extract.WithLabelValues(lvFail)
	m.find.WithLabelValues(lvSuccess)
	m.find.WithLabelValues(lvFail)
	m.upload.WithLabelValues(lvSuccess)
	m.upload.WithLabelValues(lvFail)
	m.upload.WithLabelValues(lvShared)
	return m
}
