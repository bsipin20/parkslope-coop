package main

import (
	"testing"
)

func TestAdder(t *testing.T) {
	produce := "Wheatgrass-pots organic $2.96 each Organic, New York"
	parsed := parseItem(produce)
	expected := [3]string { "Wheatgrass-pots organic ", "2.96", "Organic, New York" }

	if parsed[0] != expected[0] {
		t.Errorf("expected '%v' but got '%v'", expected[0], parsed[0])
	}
	if parsed[1] != expected[1] {
		t.Errorf("expected '%v' but got '%v'", expected[1], parsed[1])
	}
	if parsed[2] != expected[2] {
		t.Errorf("expected '%v' but got '%v'", expected[2], parsed[2])
	}

}
