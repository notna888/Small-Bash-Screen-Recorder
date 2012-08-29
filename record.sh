#!/bin/sh

echo "please input file name"
read filename
INFO=$(xwininfo -frame)

WIN_GEO=$(echo $INFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+' )
WIN_XY=$(echo $INFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' )

#echo $WIN_GEO
#echo $WIN_XY

avconv -f ALSA -ac 2 -i hw:1,0 -f x11grab -r 15 -s $WIN_GEO -i :0.0+$WIN_XY -acodec libmp3lame -vcodec msmpeg4v2 -threads 0 $filename".avi"
