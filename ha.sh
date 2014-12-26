#!/bin/bash
#haproxy
#                           5                                                                               9                                    10 timer   11  12          connections      18  19                 
# Dec 25 00:35:51 localhost haproxy[42949]: 113.142.18.121:52851 [25/Dec/2014:00:35:51.792] node_server_in finance_invest_server/tiger_node_8003 0/0/0/1/1 200 1331 - - ---- 0/0/0/0/0 0/0 "GET / HTTP/1.0"

#ip is at col 6 
#问题1：在apachelog中找出访问次数最多的10个IP。
awk '{print $6}' haproxy.log|  awk '{split($0,a,":");print a[1]}'  |sort |uniq -c|sort -nr|head -n 10
# explain:
# awk 首先将每条日志中的IP抓出来，如日志格式被自定义过，可以 -F 定义分隔符和 print指定列；
# sort进行初次排序，为的使相同的记录排列到一起；
# upiq -c 合并重复的行，并记录重复次数。
# sort -nr按照数字进行倒叙排序。
# head进行前十名筛选.

# 问题：某些ip 在干嘛？
grep "58.67.144.241" haproxy.log | awk '{print $19}' | sort | uniq -c | sort -nr | head -n 10


#问题2：在apache日志中找出访问次数最多的几个分钟。
awk '{print  $3}' haproxy.log |cut -c 1-5|sort|uniq -c|sort -nr|head
#awk 用空格分出来的第四列是[09/Jan/2010:00:59:59；
#cut -c 提取14到18个字符
#剩下的内容和问题1类似。

# 问题3：在apache日志中找到访问最多的页面：
# | sed 's/?.*/\ /g'
# sed replace ?and later with space
awk '{print $19}' haproxy.log| sed 's/?.*/\ /g' |sort |uniq -c|sort -rn|head

# 问题5: 各个node 处理请求数：
awk '{print $9}' haproxy.log |sort|uniq -c|sort -nr

# slow server-side :output all detail request url with param 
awk '{print $10 " " $19}' haproxy.log |  awk '{split($1,a,"/");print a[5]" " $2}' | sort -nr | awk '{if ($1 > 10000) print $0}'
# awk 获取ha timer
# awk split / ,获取最后一个时间（ms）－－ 服务器accept 到 close 时间
# 输出时间 ，request url路径
# 排序， 倒序
# 筛选出时间较长（1000ms 以上）的request url

# slow server-side :output all request url without param #可用于图表的基础数据
awk '{print $10 " " $19}' haproxy.log |  awk '{split($1,a,"/");print a[5]" " $2}' | sort -nr | awk '{if ($1 > 10000) print $0}' | sed 's/?.*/\ /g'

# slow server-side :output all request url without param in uniq
awk '{print $10 " " $19}' haproxy.log |  awk '{split($1,a,"/");print a[5]" " $2}' | sort -nr | awk '{if ($1 > 5000) print $0}' | sed 's/?.*/\ /g'  | awk '{print $2}' | sort| uniq -c | sort -nr

