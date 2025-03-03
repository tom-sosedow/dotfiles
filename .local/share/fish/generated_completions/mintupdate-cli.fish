# mintupdate-cli
# Autogenerated from man page /usr/share/man/man8/mintupdate-cli.8.gz
complete -c mintupdate-cli -s h -l help -d 'Show a help message and exit'
complete -c mintupdate-cli -s k -l only-kernel -d 'Only include kernel updates'
complete -c mintupdate-cli -s s -l only-security -d 'Only include security updates'
complete -c mintupdate-cli -s i -l ignore -d 'List of updates to ignore (comma-separated list of source package names)'
complete -c mintupdate-cli -s r -l refresh-cache -d 'Refresh the APT cache'
complete -c mintupdate-cli -s d -l dry-run -d 'Simulation mode, don\'t upgrade anything'
complete -c mintupdate-cli -s y -l yes -d 'Automatically answer yes to all questions and always install new configuratio…'
complete -c mintupdate-cli -l install-recommends -d 'Install recommended packages regardless of system defaults'
complete -c mintupdate-cli -l keep-configuration -d 'Always keep local changes in configuration files (use with caution)'
complete -c mintupdate-cli -s v -l version -d 'Display the current version'

