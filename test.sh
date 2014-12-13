#!/usr/bin/env sh

cd ./test/

for file in *.lua; do
	lua "$file"
done

