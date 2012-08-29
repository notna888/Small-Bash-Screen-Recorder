#!/bin/sh

echo "please input file name"
read filename #output name

Quality="h" #one day I'll get a selection thingy here

INFO=$(xwininfo -frame)

WIN_GEO=$(echo $INFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+' ) #gets the size of the window you are making
WIN_XY=$(echo $INFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' ) # gets the location of the window

#Used for checking
#echo $WIN_GEO
#echo $WIN_XY

N=1
while test "$N" -le "5"
do
        echo "Press Control C in the terminal to exit recording"
        N=$[N+1]
done
echo "sorry for spamming that but I need to make sure you get that"
echo "press enter to start recording"
read

if $Quality == "h"; then
avconv -f ALSA -ac 2 -i hw:1,0 -f x11grab -r 15 -s $WIN_GEO -i :0.0+$WIN_XY -acodec libmp3lame -vcodec msmpeg4v2 -threads 0 -same_quant $filename".avi"
else
avconv -f ALSA -ac 2 -i hw:1,0 -f x11grab -r 15 -s $WIN_GEO -i :0.0+$WIN_XY -acodec libmp3lame -vcodec msmpeg4v2 -threads 0 $filename".avi"
fi
