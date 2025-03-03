# Shell variables
# Generated by 'wal'
wallpaper='/home/tom/Bilder/Hintergründe/wallpaper-main/wallhaven-l8q85r.jpg'

# Special
background='#161217'
foreground='#e9e0e7'
cursor='#e1b8f5'

# Colors
color0='#161217'
color1='#e1b8f5'
color2='#d3c0d8'
color3='#f4b7b8'
color4='#f5d9ff'
color5='#efdcf5'
color6='#ffdada'
color7='#e9e0e7'

color8='#161217'
color9='#422255'
color10='#382c3e'
color11='#4c2527'
color12='#2b0b3f'
color13='#221728'
color14='#331113'
color15='#e9e0e7'

# FZF colors
export FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

# Fix LS_COLORS being unreadable.
export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"