# ifquery
# Autogenerated from man page /usr/share/man/man8/ifquery.8.gz
complete -c ifquery -s a -l all -d 'If given to ifup, affect all interfaces marked auto'
complete -c ifquery -l force -d 'Force configuration or deconfiguration of the interface'
complete -c ifquery -l ignore-errors -d 'If any of the commands of scripts fails, continue'
complete -c ifquery -s h -l help -d 'Show summary of options'
complete -c ifquery -l allow -d 'Only allow interfaces listed in an  allow-CLASS line in  R /etc/network/inter…'
complete -c ifquery -s i -l interfaces -d 'Read interface definitions from   FILE instead of from R /etc/network/interfa…'
complete -c ifquery -l state-dir -d 'Keep interface state in  DIR instead of in R /run/network ". "'
complete -c ifquery -s X -l exclude -d 'Exclude interfaces from the list of interfaces to operate on by the PATTERN'
complete -c ifquery -s o -d 'Set OPTION to VALUE as though it were in R /etc/network/interfaces '
complete -c ifquery -s n -l no-act -d 'Don\'t configure any interfaces or run any "up" or "down" commands'
complete -c ifquery -l no-mappings -d 'Don\'t run any mappings'
complete -c ifquery -l no-scripts -d 'Don\'t run any scripts under /etc/network/if-*. d/'
complete -c ifquery -l no-loopback -d 'Disable special handling of the loopback interface'
complete -c ifquery -s V -l version -d 'Show copyright and version information'
complete -c ifquery -s v -l verbose -d 'Show commands as they are executed'
complete -c ifquery -s l -l list -d 'For ifquery, list all the interfaces which match the specified class'
complete -c ifquery -l state -d 'For ifquery, dump the state of the interfaces'

