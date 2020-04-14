#!/bin/sh

set -e

js="www/elm.js"
minjs="www/elm.min.js"

elm make --optimize --output $js src/Main.elm

uglifyjs $js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$minjs

echo "Compiled size: $(cat $js | wc -c) bytes  ($js)"
echo "Minified size: $(cat $minjs | wc -c) bytes  ($minjs)"
echo "Gzipped size:  $(cat $minjs | gzip -c | wc -c) bytes"

rm $js
