#!/usr/bin/env bash

# Get system load
LOAD=$(uptime | cut -d: -f5 | cut -d, -f1)

# Get top processes by CPU usage, print html
CPUP=$(ps -Ao pcpu,comm --sort=-pcpu | awk '{print "<tr>","<td>",$1,"</td>","<td>",$2,"</td>","</tr>"}' | head -n 6)

# Get memory usage
MEM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')

# Get top processes by memory usage, print html
MEMP=$(ps aux --sort -rss | awk '{print "<tr>","<td>",$4,"</td>","<td>",$11,"</td>","</tr>"}' | head -n 6)

# Get free disk space
FREE=$(df -h / | tail -1 | awk '{ print $4 }')

# Show total disk space -- not currently used in output
# TOTAL=$(df -h / | tail -1 | awk '{ print $2 }')

# Get number of httpd processes
PROCESSES=$(ps aux | grep apache2 | wc -l)

# Get time and date
TIME=$(date)

# Create html file and display results in a table
cat <<-EOF
<html><head></head><body>

<table>
  <tr><td> date </td><td> $TIME</td></tr>
  <tr bgcolor="#E0E0EB"><td> free space </td><td> $FREE </td></tr>
  <tr><td> httpd processes </td><td> $PROCESSES </td></tr>
  <tr bgcolor="#E0E0EB"><td valign="top"> load </td><td  valign="top"> $LOAD </td>
      <td><table>$CPUP</table></tr> 
  <tr><td valign="top"> mem usage </td><td valign="top"> $MEM </td> 
      <td><table>$MEMP</table></td> 
    </tr>
</table>

</body></html>
EOF
