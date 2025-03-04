package tug

import (
	"fmt"
	"testing"

	"github.com/khulnasoft/tug/src/util"
)

func TestChunkList(t *testing.T) {
	// FIXME global
	sortCriteria = []criterion{byScore, byLength}

	cl := NewChunkList(NewChunkCache(), func(item *Item, s []byte) bool {
		item.text = util.ToChars(s)
		return true
	})

	// Snapshot
	snapshot, count, _ := cl.Snapshot(0)
	if len(snapshot) > 0 || count > 0 {
		t.Error("Snapshot should be empty now")
	}

	// Add some data
	cl.Push([]byte("hello"))
	cl.Push([]byte("world"))

	// Previously created snapshot should remain the same
	if len(snapshot) > 0 {
		t.Error("Snapshot should not have changed")
	}

	// But the new snapshot should contain the added items
	snapshot, count, _ = cl.Snapshot(0)
	if len(snapshot) != 1 && count != 2 {
		t.Error("Snapshot should not be empty now")
	}

	// Check the content of the ChunkList
	chunk1 := snapshot[0]
	if chunk1.count != 2 {
		t.Error("Snapshot should contain only two items")
	}
	if chunk1.items[0].text.ToString() != "hello" ||
		chunk1.items[1].text.ToString() != "world" {
		t.Error("Invalid data")
	}
	if chunk1.IsFull() {
		t.Error("Chunk should not have been marked full yet")
	}

	// Add more data
	for i := 0; i < chunkSize*2; i++ {
		cl.Push([]byte(fmt.Sprintf("item %d", i)))
	}

	// Previous snapshot should remain the same
	if len(snapshot) != 1 {
		t.Error("Snapshot should stay the same")
	}

	// New snapshot
	snapshot, count, _ = cl.Snapshot(0)
	if len(snapshot) != 3 || !snapshot[0].IsFull() ||
		!snapshot[1].IsFull() || snapshot[2].IsFull() || count != chunkSize*2+2 {
		t.Error("Expected two full chunks and one more chunk")
	}
	if snapshot[2].count != 2 {
		t.Error("Unexpected number of items")
	}

	cl.Push([]byte("hello"))
	cl.Push([]byte("world"))

	lastChunkCount := snapshot[len(snapshot)-1].count
	if lastChunkCount != 2 {
		t.Error("Unexpected number of items:", lastChunkCount)
	}
}

func TestChunkListTail(t *testing.T) {
	cl := NewChunkList(NewChunkCache(), func(item *Item, s []byte) bool {
		item.text = util.ToChars(s)
		return true
	})
	total := chunkSize*2 + chunkSize/2
	for i := 0; i < total; i++ {
		cl.Push([]byte(fmt.Sprintf("item %d", i)))
	}

	snapshot, count, changed := cl.Snapshot(0)
	assertCount := func(expected int, shouldChange bool) {
		if count != expected || CountItems(snapshot) != expected {
			t.Errorf("Unexpected count: %d (expected: %d)", count, expected)
		}
		if changed != shouldChange {
			t.Error("Unexpected change status")
		}
	}
	assertCount(total, false)

	tail := chunkSize + chunkSize/2
	snapshot, count, changed = cl.Snapshot(tail)
	assertCount(tail, true)

	snapshot, count, changed = cl.Snapshot(tail)
	assertCount(tail, false)

	snapshot, count, changed = cl.Snapshot(0)
	assertCount(tail, false)

	tail = chunkSize / 2
	snapshot, count, changed = cl.Snapshot(tail)
	assertCount(tail, true)
}
