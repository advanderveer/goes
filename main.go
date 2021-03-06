// +build wasm

package main

import (
	"fmt"
	"syscall/js"
	"time"
)

func main() {
	go func() {
		for range time.Tick(time.Millisecond * 2200) {
			js.Global().Set("foo", time.Now().String())
		}
	}()

	for range time.Tick(time.Second * 3) {
		fmt.Println("hello, 日本語 :", js.Global().Get("foo"))
	}
}
