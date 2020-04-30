#!/bin/sh
cd "/math-lab.git/HA/eulerline/"
mkdir ketcindyjs
cd "/Applications/kettex/texlive/texmf-dist/scripts/ketcindy/ketcindyjs"
cp -r -p katex /math-lab.git/HA/eulerline/ketcindyjs
cp -p Cindy.js /math-lab.git/HA/eulerline/ketcindyjs
cp -p Cindy.js.map /math-lab.git/HA/eulerline/ketcindyjs
cp -p CindyJS.css /math-lab.git/HA/eulerline/ketcindyjs
cp -p katex-plugin.js /math-lab.git/HA/eulerline/ketcindyjs
cp -p webfont.js /math-lab.git/HA/eulerline/ketcindyjs
exit 0
