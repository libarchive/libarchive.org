#!/bin/sh
tree -T "Libarchive downloads" -H "." -L 1 -r -I "index.html" -i --noreport downloads | sed -E -e 's,^.*<a href=".">.</a>.*,,' > downloads/index.html
cd downloads && (
	FILES=`ls -1 *.zip *.tar* *.asc | sort -r`
	rm -f .sha256sums
	for FILE in ${FILES}
	do
		openssl sha256 ${FILE} >> .sha256sums
	done
	mv .sha256sums sha256sums
)
