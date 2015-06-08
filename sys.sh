#!/usr/bin/env bash

LOAD=$(uptime | cut -d: -f5 | cut -d, -f1)
CPUP=$(ps -Ao pcpu,comm --sort=-pcpu | awk '{print "<tr>","<td>",$1,"</td>","<td>",$2,"</td>","</tr>"}' | head -n 6)
MEM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
MEMP=$(ps aux --sort -rss | awk '{print "<tr>","<td>",$4,"</td>","<td>",$11,"</td>","</tr>"}' | head -n 6)
FREE=$(df -h / | tail -1 | awk '{ print $4 }')
TOTAL=$(df -h / | tail -1 | awk '{ print $2 }')
PROCESSES=$(ps aux | grep apache2 | wc -l)
TIME=$(date)

cat <<-EOF
<html><head>
   <meta name=viewport content="width=device-width, initial-scale=1">
   <div align="center"><hr><h1><a href="http://rev0.lt">rev0.lt</a> | status</h1><hr></div>

</head>
<body>

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
