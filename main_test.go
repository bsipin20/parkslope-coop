package main

import (
	"testing"
	"reflect"
)

func TestAdder(t *testing.T) {
	produce := "Wheatgrass-pots organic $2.96 each Organic, New York"
	parsed := parseItem(produce)
	expected := [1]string { "resulted" }

	if !reflect.DeepEqual(parsed, expected) {
		t.Errorf("expected '%v' but got '%v'", parsed, expected)
	}
}
