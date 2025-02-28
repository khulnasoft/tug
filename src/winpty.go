//go:build !windows

package tug

import "errors"

func needWinpty(_ *Options) bool {
	return false
}

func runWinpty(_ []string, _ *Options) (int, error) {
	return ExitError, errors.New("Not supported")
}
