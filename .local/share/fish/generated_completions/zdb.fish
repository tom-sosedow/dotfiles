# zdb
# Autogenerated from man page /usr/share/man/man8/zdb.8.gz
complete -c zdb -s b -d 'Display statistics regarding the number, size logical, physical and allocated…'
complete -c zdb -s c -d 'Verify the checksum of all metadata blocks while printing block statistics se…'
complete -c zdb -s C -d 'Display information about the configuration'
complete -c zdb -s d -d 'Display information about datasets'
complete -c zdb -s D -d 'Display deduplication statistics, including the deduplication ratio dedup, co…'
complete -c zdb -o DD -d 'Display a histogram of deduplication statistics, showing the allocated physic…'
complete -c zdb -o DDD -d 'Display the statistics independently for each deduplication table'
complete -c zdb -o DDDD -d 'Dump the contents of the deduplication tables describing duplicate blocks'
complete -c zdb -o DDDDD -d 'Also dump the contents of the deduplication tables describing unique blocks'
complete -c zdb -s E -d 'Decode and display block from an embedded block pointer specified by the word…'
complete -c zdb -s h -d 'Display pool history similar to zdb zpool Cm history, but include internal ch…'
complete -c zdb -s i -d 'Display information about intent log ZIL entries relating to each dataset'
complete -c zdb -s k -d 'Examine the checkpointed state of the pool'
complete -c zdb -s l -d 'Read the vdev labels and L2ARC header from the specified device'
complete -c zdb -o ll -d 'In addition display label space usage stats'
complete -c zdb -o lll -d 'Display every configuration, unique or not'
complete -c zdb -s L -d 'Disable leak detection and the loading of space maps'
complete -c zdb -s m -d 'Display the offset, spacemap, free space of each metaslab, all the log spacem…'
complete -c zdb -o mm -d 'Also display information about the on-disk free space histogram associated wi…'
complete -c zdb -o mmm -d 'Display the maximum contiguous free space, the in-core free space histogram, …'
complete -c zdb -o mmmm -d 'Display every spacemap record'
complete -c zdb -s M -d 'Display the offset, spacemap, and free space of each metaslab'
complete -c zdb -o MM -d 'Also display information about the maximum contiguous free space and the perc…'
complete -c zdb -o MMM -d 'Display every spacemap record'
complete -c zdb -s N -d 'Same as d but force zdb to interpret the dataset | objset ID in poolname Ns O…'
complete -c zdb -s O -d 'Look up the specified path inside of the dataset and display its metadata and…'
complete -c zdb -s r -d 'Copy the specified path inside of the dataset to the specified destination'
complete -c zdb -s s -d 'Report statistics on zdb zdb I/O'
complete -c zdb -s S -d 'Simulate the effects of deduplication, constructing a DDT and then display th…'
complete -c zdb -s u -d 'Display the current uberblock.  El Pp Other options: -tag -width Ds'
complete -c zdb -s A -d 'Do not abort should any assertion fail'
complete -c zdb -o AA -d 'Enable panic recovery, certain errors which would otherwise be fatal are demo…'
complete -c zdb -o AAA -d 'Do not abort if asserts fail and also enable panic recovery'
complete -c zdb -s e -d 'Operate on an exported pool, not present in /etc/zfs/zpool. cache'
complete -c zdb -s x -d 'All blocks accessed will be copied to files in the specified directory'
complete -c zdb -s F -d 'Attempt to make an unreadable pool readable by trying progressively older tra…'
complete -c zdb -s G -d 'Dump the contents of the zfs_dbgmsg buffer before exiting zdb'
complete -c zdb -s I -d 'Limit the number of outstanding checksum I/Os to the specified value'
complete -c zdb -s o -d 'Set the given global libzpool variable to the provided value'
complete -c zdb -s P -d 'Print numbers in an unscaled form more amenable to parsing, e. g'
complete -c zdb -s t -d 'Specify the highest transaction to use when searching for uberblocks'
complete -c zdb -s U -d 'Use a cache file other than /etc/zfs/zpool. cache'
complete -c zdb -s v -d 'Enable verbosity.  Specify multiple times for increased verbosity'
complete -c zdb -s V -d 'Attempt verbatim import'
complete -c zdb -s X -d 'Attempt extreme transaction rewind, that is attempt the same recovery as F bu…'
complete -c zdb -s Y -d 'Attempt all possible combinations when reconstructing indirect split blocks'
complete -c zdb -s y -d 'Perform validation for livelists that are being deleted'
