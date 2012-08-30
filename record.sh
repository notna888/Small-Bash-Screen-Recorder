#!/bin/sh

echo "please input file name"
read filename #output name

echo "click the window you want to record"

INFO=$(xwininfo -frame)

WIN_GEO=$(echo $INFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+' ) #gets the size of the window you are making
WIN_XY=$(echo $INFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' ) # gets the location of the window

echo "Press Control C in the terminal to exit recording"
echo "press enter to start recording"
read DummyVarible

avconv -f ALSA -ac 2 -i hw:1,0 -f x11grab -r 15 -s $WIN_GEO -i :0.0+$WIN_XY -acodec libmp3lame -vcodec msmpeg4v2 -threads 0 -same_quant $filename".avi"
