# 工具指令手册

# CPU类

## sysbench 

``` 
Usage:
  sysbench [options]... [testname] [command]

Commands implemented by most tests: prepare run cleanup help

General options:
  --threads=N                     number of threads to use [1]
  --events=N                      limit for total number of events [0]
  --time=N                        limit for total execution time in seconds [10]
  --forced-shutdown=STRING        number of seconds to wait after the --time limit before forcing shutdown, or 'off' to disable [off]
  --thread-stack-size=SIZE        size of stack per thread [64K]
  --rate=N                        average transactions rate. 0 for unlimited rate [0]
  --report-interval=N             periodically report intermediate statistics with a specified interval in seconds. 0 disables intermediate reports [0]
  --report-checkpoints=[LIST,...] dump full statistics and reset all counters at specified points in time. The argument is a list of comma-separated values representing the amount of time in seconds elapsed from start of test when report checkpoint(s) must be performed. Report checkpoints are off by default. []
  --debug[=on|off]                print more debugging info [off]
  --validate[=on|off]             perform validation checks where possible [off]
  --help[=on|off]                 print help and exit [off]
  --version[=on|off]              print version and exit [off]
  --config-file=FILENAME          File containing command line options
  --tx-rate=N                     deprecated alias for --rate [0]
  --max-requests=N                deprecated alias for --events [0]
  --max-time=N                    deprecated alias for --time [0]
  --num-threads=N                 deprecated alias for --threads [1]

Pseudo-Random Numbers Generator options:
  --rand-type=STRING random numbers distribution {uniform,gaussian,special,pareto} [special]
  --rand-spec-iter=N number of iterations used for numbers generation [12]
  --rand-spec-pct=N  percentage of values to be treated as 'special' (for special distribution) [1]
  --rand-spec-res=N  percentage of 'special' values to use (for special distribution) [75]
  --rand-seed=N      seed for random number generator. When 0, the current time is used as a RNG seed. [0]
  --rand-pareto-h=N  parameter h for pareto distribution [0.2]

Log options:
  --verbosity=N verbosity level {5 - debug, 0 - only critical messages} [3]

  --percentile=N       percentile to calculate in latency statistics (1-100). Use the special value of 0 to disable percentile calculations [95]
  --histogram[=on|off] print latency histogram in report [off]

General database options:

  --db-driver=STRING  specifies database driver to use ('help' to get list of available drivers) [mysql]
  --db-ps-mode=STRING prepared statements usage mode {auto, disable} [auto]
  --db-debug[=on|off] print database-specific debug information [off]


Compiled-in database drivers:
  mysql - MySQL driver
  pgsql - PostgreSQL driver

mysql options:
  --mysql-host=[LIST,...]          MySQL server host [localhost]
  --mysql-port=[LIST,...]          MySQL server port [3306]
  --mysql-socket=[LIST,...]        MySQL socket
  --mysql-user=STRING              MySQL user [sbtest]
  --mysql-password=STRING          MySQL password []
  --mysql-db=STRING                MySQL database name [sbtest]
  --mysql-ssl[=on|off]             use SSL connections, if available in the client library [off]
  --mysql-ssl-cipher=STRING        use specific cipher for SSL connections []
  --mysql-compression[=on|off]     use compression, if available in the client library [off]
  --mysql-debug[=on|off]           trace all client library calls [off]
  --mysql-ignore-errors=[LIST,...] list of errors to ignore, or "all" [1213,1020,1205]
  --mysql-dry-run[=on|off]         Dry run, pretend that all MySQL client API calls are successful without executing them [off]

pgsql options:
  --pgsql-host=STRING     PostgreSQL server host [localhost]
  --pgsql-port=N          PostgreSQL server port [5432]
  --pgsql-user=STRING     PostgreSQL user [sbtest]
  --pgsql-password=STRING PostgreSQL password []
  --pgsql-db=STRING       PostgreSQL database name [sbtest]

Compiled-in tests:
  fileio - File I/O test
  cpu - CPU performance test
  memory - Memory functions speed test
  threads - Threads subsystem performance test
  mutex - Mutex performance test

See 'sysbench <testname> help' for a list of options for each test.
``` 


# 内存

# 磁盘类

## dd 
```
Usage: dd [OPERAND]...
  or:  dd OPTION
Copy a file, converting and formatting according to the operands.

  bs=BYTES        read and write up to BYTES bytes at a time
  cbs=BYTES       convert BYTES bytes at a time
  conv=CONVS      convert the file as per the comma separated symbol list
  count=N         copy only N input blocks
  ibs=BYTES       read up to BYTES bytes at a time (default: 512)
  if=FILE         read from FILE instead of stdin
  iflag=FLAGS     read as per the comma separated symbol list
  obs=BYTES       write BYTES bytes at a time (default: 512)
  of=FILE         write to FILE instead of stdout
  oflag=FLAGS     write as per the comma separated symbol list
  seek=N          skip N obs-sized blocks at start of output
  skip=N          skip N ibs-sized blocks at start of input
  status=LEVEL    The LEVEL of information to print to stderr;
                  'none' suppresses everything but error messages,
                  'noxfer' suppresses the final transfer statistics,
                  'progress' shows periodic transfer statistics

N and BYTES may be followed by the following multiplicative suffixes:
c =1, w =2, b =512, kB =1000, K =1024, MB =1000*1000, M =1024*1024, xM =M
GB =1000*1000*1000, G =1024*1024*1024, and so on for T, P, E, Z, Y.

Each CONV symbol may be:

  ascii     from EBCDIC to ASCII
  ebcdic    from ASCII to EBCDIC
  ibm       from ASCII to alternate EBCDIC
  block     pad newline-terminated records with spaces to cbs-size
  unblock   replace trailing spaces in cbs-size records with newline
  lcase     change upper case to lower case
  ucase     change lower case to upper case
  sparse    try to seek rather than write the output for NUL input blocks
  swab      swap every pair of input bytes
  sync      pad every input block with NULs to ibs-size; when used
            with block or unblock, pad with spaces rather than NULs
  excl      fail if the output file already exists
  nocreat   do not create the output file
  notrunc   do not truncate the output file
  noerror   continue after read errors
  fdatasync  physically write output file data before finishing
  fsync     likewise, but also write metadata

Each FLAG symbol may be:

  append    append mode (makes sense only for output; conv=notrunc suggested)
  direct    use direct I/O for data
  directory  fail unless a directory
  dsync     use synchronized I/O for data
  sync      likewise, but also for metadata
  fullblock  accumulate full blocks of input (iflag only)
  nonblock  use non-blocking I/O
  noatime   do not update access time
  nocache   discard cached data
  noctty    do not assign controlling terminal from file
  nofollow  do not follow symlinks
  count_bytes  treat 'count=N' as a byte count (iflag only)
  skip_bytes  treat 'skip=N' as a byte count (iflag only)
  seek_bytes  treat 'seek=N' as a byte count (oflag only)

Sending a USR1 signal to a running 'dd' process makes it
print I/O statistics to standard error and then resume copying.

  $ dd if=/dev/zero of=/dev/null& pid=$!
  $ kill -USR1 $pid; sleep 1; kill $pid
  18335302+0 records in
  18335302+0 records out
  9387674624 bytes (9.4 GB) copied, 34.6279 seconds, 271 MB/s

Options are:

      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
For complete documentation, run: info coreutils 'dd invocation'
```


## ioping

```
ioping: invalid option -- '-'
 Usage: ioping [-ABCDRLWYykq] [-c count] [-i interval] [-s size] [-S wsize]
               [-o offset] [-w deadline] [-pP period] directory|file|device
        ioping -h | -v

      -c <count>      stop after <count> requests
      -i <interval>   interval between requests (1s)
      -l <speed>      speed limit in bytes per second
      -t <time>       minimal valid request time (0us)
      -T <time>       maximum valid request time
      -s <size>       request size (4k)
      -S <wsize>      working set size (1m)
      -o <offset>     working set offset (0)
      -w <deadline>   stop after <deadline> time passed
      -p <period>     print raw statistics for every <period> requests
      -P <period>     print raw statistics for every <period> in time
      -A              use asynchronous I/O
      -C              use cached I/O (no cache flush/drop)
      -B              print final statistics in raw format
      -D              use direct I/O (O_DIRECT)
      -R              seek rate test
      -L              use sequential operations
      -W              use write I/O (please read manpage)
      -G              read-write ping-pong mode
      -Y              use sync I/O (O_SYNC)
      -y              use data sync I/O (O_DSYNC)
      -k              keep and reuse temporary file (ioping.tmp)
      -q              suppress human-readable output
      -h              display this message and exit
      -v              display version and exit

```

## fio 
```
fio-3.7
fio [options] [job options] <job file(s)>
  --debug=options       Enable debug logging. May be one/more of:
                        process,file,io,mem,blktrace,verify,random,parse,
                        diskutil,job,mutex,profile,time,net,rate,compress,
                        steadystate,helperthread
  --parse-only          Parse options only, don't start any IO
  --output              Write output to file
  --bandwidth-log       Generate aggregate bandwidth logs
  --minimal             Minimal (terse) output
  --output-format=type  Output format (terse,json,json+,normal)
  --terse-version=type  Set terse version output format (default 3, or 2 or 4)
  --version             Print version info and exit
  --help                Print this page
  --cpuclock-test       Perform test/validation of CPU clock
  --crctest=[type]      Test speed of checksum functions
  --cmdhelp=cmd         Print command help, "all" for all of them
  --enghelp=engine      Print ioengine help, or list available ioengines
  --enghelp=engine,cmd  Print help for an ioengine cmd
  --showcmd             Turn a job file into command line options
  --eta=when            When ETA estimate should be printed
                        May be "always", "never" or "auto"
  --eta-newline=time    Force a new line for every 'time' period passed
  --status-interval=t   Force full status dump every 't' period passed
  --readonly            Turn on safety read-only checks, preventing writes
  --section=name        Only run specified section in job file, multiple sections can be specified
  --alloc-size=kb       Set smalloc pool to this size in kb (def 16384)
  --warnings-fatal      Fio parser warnings are fatal
  --max-jobs=nr         Maximum number of threads/processes to support
  --server=args         Start a backend fio server
  --daemonize=pidfile   Background fio server, write pid to file
  --client=hostname     Talk to remote backend(s) fio server at hostname
  --remote-config=file  Tell fio server to load this local job file
  --idle-prof=option    Report cpu idleness on a system or percpu basis
                        (option=system,percpu) or run unit work
                        calibration only (option=calibrate)
  --inflate-log=log     Inflate and output compressed log
  --trigger-file=file   Execute trigger cmd when file exists
  --trigger-timeout=t   Execute trigger at this time
  --trigger=cmd         Set this command as local trigger
  --trigger-remote=cmd  Set this command as remote trigger
  --aux-path=path       Use this path for fio state generated files

Fio was written by Jens Axboe <axboe@kernel.dk>
```

# Ether & network 

## sockperf 

```
sockperf is a tool for testing network latency and throughput.
version 3.6-no.git

Usage: sockperf <subcommand> [options] [args]
Type: 'sockperf <subcommand> --help' for help on a specific subcommand.
Type: 'sockperf --version' to see the program version number.

Available subcommands:
   help (h ,?)          Display list of supported commands.
   under-load (ul)      Run sockperf client for latency under load test.
   ping-pong (pp)       Run sockperf client for latency test in ping pong mode.
   playback (pb)        Run sockperf client for latency test using playback of predefined traffic, based on timeline and message size.
   throughput (tp)      Run sockperf client for one way throughput test.
   server (sr)          Run sockperf as a server.
```


# ElasticSeearch (ES)

## esrally 
```bash


```