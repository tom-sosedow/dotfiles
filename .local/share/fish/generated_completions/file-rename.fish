# file-rename
# Autogenerated from man page /usr/share/man/man1/file-rename.1p.gz
complete -c file-rename -s v -l verbose -d 'Verbose: print names of files successfully renamed'
complete -c file-rename -s 0 -l null -d 'Use 0 as record separator when reading from \\s-1STDIN. \\s0'
complete -c file-rename -s n -l nono -d 'No action: print names of files to be renamed, but don\'t rename'
complete -c file-rename -s f -l force -d 'Over write: allow existing files to be over-written'
complete -c file-rename -l path -l fullpath -d 'Rename full path: including any directory component.   \\s-1DEFAULT\\s0'
complete -c file-rename -s d -l filename -l nopath -l nofullpath -d 'Do not rename directory: only rename filename component of path'
complete -c file-rename -s h -l help -d 'Help: print \\s-1SYNOPSIS\\s0 and \\s-1OPTIONS. \\s0'
complete -c file-rename -s m -l man -d 'Manual: print manual page'
complete -c file-rename -s V -l version -d 'Version: show version number'
complete -c file-rename -s u -l unicode -d 'Treat filenames as perl (unicode) strings when running the user-supplied code'
complete -c file-rename -s e -d 'Expression: code to act on files name'

