//go:build !windows

package tug

import (
	"os"
	"os/signal"
	"syscall"

	"golang.org/x/sys/unix"
)

func notifyOnResize(resizeChan chan<- os.Signal) {
	signal.Notify(resizeChan, syscall.SIGWINCH)
}

func notifyStop(p *os.Process) {
	pid := p.Pid
	pgid, err := unix.Getpgid(pid)
	if err == nil {
		pid = pgid * -1
	}
	unix.Kill(pid, syscall.SIGTSTP)
}
