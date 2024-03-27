#!/usr/bin/env bash
#	default color: 178984
oldglyph=#4d333a
newglyph=#4e3244

#	Front
#	default color: 36d7b7
oldfront=#8a5d68
newfront=#8d5a7c

#	Back
#	default color: 1ba39c
oldback=#5f4048
newback=#613e55

sed -i "s/#524954/$oldglyph/g" $1
sed -i "s/#9b8aa0/$oldfront/g" $1
sed -i "s/#716475/$oldback/g" $1
sed -i "s/$oldglyph;/$newglyph;/g" $1
sed -i "s/$oldfront;/$newfront;/g" $1
sed -i "s/$oldback;/$newback;/g" $1
