#!/bin/bash
set -e

function print_help {
	printf "Available Commands:\n";
	awk -v sq="'" '/^function run_([a-zA-Z0-9-]*)\s*/ {print "-e " sq NR "p" sq " -e " sq NR-1 "p" sq }' make.sh \
		| while read line; do eval "sed -n $line make.sh"; done \
		| paste -d"|" - - \
		| sed -e 's/^/  /' -e 's/function run_//' -e 's/#//' -e 's/{/	/' \
		| awk -F '|' '{ print "  " $2 "\t" $1}' \
		| expand -t 30
}

function run_build { # build the Javascript
    # GOOS=js GOARCH=wasm go build -o main.wasm
    
	/Users/adam/Projects/go/src/github.com/WebAssembly/binaryen/bin/wasm2js --emscripten -O main.wasm -o hello_go.js

}

case $1 in
	"build") run_build ;;
	*) print_help ;;
esac