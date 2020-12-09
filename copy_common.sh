#!/bin/bash

copy_code_to_playground() {
	target="$1"
	
	rm -rf "$target/Common"
	cp -R "Common" "$target/Common"
}

for playground in *.playground/Sources; do
	copy_code_to_playground $playground
done
