#!/bin/bash
#假设apache日志格式为：
# 118.78.199.98 – - [09/Jan/2010:00:59:59 +0800] “GET /Public/Css/index.css HTTP/1.1″ 304 – “http://www.a.cn/common/index.php” “Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; GTB6.3)”

类似问题1和2，唯一特殊是用sed的替换功能将”http://www.a.cn/common/index.php”替换成括号内的内容：”http://www.a.cn（/common/index.php）”

问题4：在apache日志中找出访问次数最多（负载最重）的几个时间段（以分钟为单位），然后在看看这些时间哪几个IP访问的最多？
1,查看apache进程:
ps aux | grep httpd | grep -v grep | wc -l

2,查看80端口的tcp连接:
netstat -tan | grep "ESTABLISHED" | grep ":80" | wc -l

3,通过日志查看当天ip连接数，过滤重复:
cat access_log | grep "19/May/2011" | awk '{print $2}' | sort | uniq -c | sort -nr

4,当天ip连接数最高的ip都在干些什么(原来是蜘蛛):
cat access_log | grep "19/May/2011:00" | grep "61.135.166.230" | awk '{print $8}' | sort | uniq -c | sort -nr | head -n 10
5,当天访问页面排前10的url:
cat access_log | grep "19/May/2010:00" | awk '{print $8}' | sort | uniq -c | sort -nr | head -n 10

6,用tcpdump嗅探80端口的访问看看谁最高
tcpdump -i eth0 -tnn dst port 80 -c 1000 | awk -F"." '{print $1"."$2"."$3"."$4}' | sort | uniq -c | sort -nr

接着从日志里查看该ip在干嘛:
cat access_log | grep 220.181.38.183| awk '{print $1"/t"$8}' | sort | uniq -c | sort -nr | less

7,查看某一时间段的ip连接数:
grep "2006:0[7-8]" www20110519.log | awk '{print $2}' | sort | uniq -c| sort -nr | wc -l

8,当前WEB服务器中联接次数最多的20条ip地址:
netstat -ntu |awk '{print $5}' |sort | uniq -c| sort -n -r | head -n 20

9,查看日志中访问次数最多的前10个IP
cat access_log |cut -d ' ' -f 1 |sort |uniq -c | sort -nr | awk '{print $0 }' | head -n 10 |less
10,查看日志中出现100次以上的IP
cat access_log |cut -d ' ' -f 1 |sort |uniq -c | awk '{if ($1 > 100) print $0}'｜sort -nr |less

11,查看最近访问量最高的文件
cat access_log |tail -10000|awk '{print $7}'|sort|uniq -c|sort -nr|less
12,查看日志中访问超过100次的页面
cat access_log | cut -d ' ' -f 7 | sort |uniq -c | awk '{if ($1 > 100) print $0}' | less

13,列出传输时间超过 30 秒的文件
cat access_log|awk '($NF > 30){print $7}'|sort -n|uniq -c|sort -nr|head -20

14,列出最最耗时的页面(超过60秒的)的以及对应页面发生次数
cat access_log |awk '($NF > 60 && $7~//.php/){print $7}'|sort -n|uniq -c|sort -nr|head -100
