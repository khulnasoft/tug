package tug

import (
	"testing"
	"time"

	"github.com/khulnasoft/tug/src/util"
)

func TestReadFromCommand(t *testing.T) {
	strs := []string{}
	eb := util.NewEventBox()
	exec := util.NewExecutor("")
	reader := NewReader(
		func(s []byte) bool { strs = append(strs, string(s)); return true },
		eb, exec, false, true)

	reader.startEventPoller()

	// Check EventBox
	if eb.Peek(EvtReadNew) {
		t.Error("EvtReadNew should not be set yet")
	}

	// Normal command
	counter := 0
	ready := func() {
		counter++
	}
	reader.fin(reader.readFromCommand(`echo abc&&echo def`, nil, ready))
	if len(strs) != 2 || strs[0] != "abc" || strs[1] != "def" || counter != 1 {
		t.Errorf("%s", strs)
	}

	// Check EventBox again
	eb.WaitFor(EvtReadFin)

	// Wait should return immediately
	eb.Wait(func(events *util.Events) {
		events.Clear()
	})

	// EventBox is cleared
	if eb.Peek(EvtReadNew) {
		t.Error("EvtReadNew should not be set yet")
	}

	// Make sure that event poller is finished
	time.Sleep(readerPollIntervalMax)

	// Restart event poller
	reader.startEventPoller()

	// Failing command
	reader.fin(reader.readFromCommand(`no-such-command`, nil, ready))
	strs = []string{}
	if len(strs) > 0 || counter != 2 {
		t.Errorf("%s", strs)
	}

	// Check EventBox again
	if eb.Peek(EvtReadNew) {
		t.Error("Command failed. EvtReadNew should not be set")
	}
	if !eb.Peek(EvtReadFin) {
		t.Error("EvtReadFin should be set")
	}
}
