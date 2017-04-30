top | head -n 12

top -b -n 1 | head -n 12 | tail -n 6

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
    1 root      20   0   37672   5876   4136 S   0.0  0.6   0:01.77 systemd
    2 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kthreadd
    3 root      20   0       0      0      0 S   0.0  0.0   0:00.05 ksoftirqd/0
    5 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H
    7 root      20   0       0      0      0 S   0.0  0.0   0:00.56 rcu_sched

uptime

#-----------------------------------------------------------------------------------

iostat | tail -n 5

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda               1.06        22.77        37.90     405448     674778
dm-0              1.39        20.39        37.90     362945     674760
dm-1              0.01         0.18         0.00       3264          0