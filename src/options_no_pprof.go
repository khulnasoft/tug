//go:build !pprof
// +build !pprof

package tug

import "errors"

func (o *Options) initProfiling() error {
	if o.CPUProfile != "" || o.MEMProfile != "" || o.BlockProfile != "" || o.MutexProfile != "" {
		return errors.New("error: profiling not supported: TUG must be built with '-tags=pprof' to enable profiling")
	}
	return nil
}
