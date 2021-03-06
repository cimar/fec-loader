#!/bin/bash

set -euo pipefail

for file in $(find $1 -name "2019*.zip" -not -name "*.nofiles.*");
do
	base=$(basename $file .zip)
	path="/tmp/"$base
	rm -rf $path
	mkdir -p $path
	unzip -qq -d $path $file
	for filing in $(find $path -name "*.fec");
	do
		echo $filing
		cat $filing | gzip -9 > $2$(basename $filing)".gz"
	done
done
