#!/bin/bash
#----------------------------------------------------------------------
# LoadAverage
#----------------------------------------------------------------------
# Количество процессоров (ядер), с учетом "hyper threading"
p=$(cat /proc/cpuinfo | grep -i 'core id' | wc -l)
#----------------------------------------------------------------------
# Прогрессивно вытягиваем данные из аптайма
echo "<table border=\"1\"><tr>"
uptime | awk -F "," '{ print "<td>"$1","$2", load average: </td>" }';
#----------------------------------------------------------------------
cat /proc/loadavg | awk -v LIM1=0.5 -vLIM2=0.9 -v PROCC=$p -F " "     \
' { na = $1; nb = $2; nc = $3;                                        \
  { if (na/PROCC > LIM1)                                              \
    { if (na/PROCC > LIM2) print "<td><span style=\"color: red;\">";  \
      else print "<td><span style=\"color: orange;\">"; }             \
    else print "<td><span style=\"color: green;\">"; }                \
  print na"</span></td>";                                             \
  { if (nb/PROCC > LIM1)                                              \
    { if (nb/PROCC > LIM2) print "<td><span style=\"color: red;\">";  \
      else print "<td><span style=\"color: orange;\">"; }             \
    else print "<td><span style=\"color: green;\">"; }                \
  print nb"</span></td>";                                             \
  { if (nc/PROCC > LIM1)                                              \
    { if (nc/PROCC > LIM2) print "<td><span style=\"color: red;\">";  \
      else print "<td><span style=\"color: orange;\">"; }             \
    else print "<td><span style=\"color: green;\">"; }                \
  print nc"</span></td>";}'
#----------------------------------------------------------------------
echo "</tr></table>"
#----------------------------------------------------------------------