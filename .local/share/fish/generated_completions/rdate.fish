# rdate
# Autogenerated from man page /usr/share/man/man8/rdate.8.gz
complete -c rdate -s 4 -d 'Force rdate to use IPv4 addresses only'
complete -c rdate -s 6 -d 'Force rdate to use IPv6 addresses only'
complete -c rdate -s a -d 'Use the adjtime(2) call to gradually skew the local time to the remote time r…'
complete -c rdate -s b -d 'Use adjtime if clock difference is at most sec seconds or hop if difference i…'
complete -c rdate -s c -d 'Correct leap seconds.  Sometimes required when synchronizing to an NTP server'
complete -c rdate -s n -d 'Use SNTP (old RFC 2030, currently RFC 5905) instead of the RFC 868 time proto…'
complete -c rdate -s o -d 'Use port \'port\' instead of port 37 (RFC 868) or 123 (SNTP, RFC 5905)'
complete -c rdate -s p -d 'Do not set, just print the remote time'
complete -c rdate -s s -d 'Do not print the time'
complete -c rdate -s u -d 'Use UDP instead of TCP as transport (for RFC 868 only; see -n option)'
complete -c rdate -s t -d 'Does not set time if it took more than msec milliseconds to fetch time from n…'
complete -c rdate -s v -d 'Verbose output.  Always show the adjustment'
