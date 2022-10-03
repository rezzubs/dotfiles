#!/bin/bash

set -e

output=pscircle.png

pscircle \
    --output=$output \
    --output-width=3840 \
    --output-height=2160 \
    --memlist-show=false \
    --cpulist-show=false \
    --root-pid=1 \
	--tree-sector-angle=3.3 \
	--tree-center=0:-900 \
	--tree-rotate=true \
	--tree-rotation-angle=0.08 \
    --background-color=181825 \
    --tree-font-size=25 \
    --dot-radius=10 \
    --dot-border-width=0 \
    --dot-color-min=cba6f7 \
    --dot-color-max=f9e2af \
    --link-color-min=45475a \
    --link-color-max=585b70 \
    --tree-font-color=bac2de \
    --tree-font-face="JetBrains Mono" \
    --tree-radius-increment=250




if command -v feh >/dev/null; then
	feh --bg-max $output
	rm $output
fi

