#!/usr/bin/env bash
#	default color: 178984
oldglyph=#314349
newglyph=#1c3140

#	Front
#	default color: 36d7b7
oldfront=#587a84
newfront=#375f7c

#	Back
#	default color: 1ba39c
oldback=#3d545b
newback=#264155

sed -i "s/#524954/$oldglyph/g" $1
sed -i "s/#9b8aa0/$oldfront/g" $1
sed -i "s/#716475/$oldback/g" $1
sed -i "s/$oldglyph;/$newglyph;/g" $1
sed -i "s/$oldfront;/$newfront;/g" $1
sed -i "s/$oldback;/$newback;/g" $1
