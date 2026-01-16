#!/bin/bash

echo "=============================="
echo "   SYSTEM DIAGNOSIS REPORT"
echo "=============================="
echo

# Date & Host
echo "Date       : $(date)"
echo "Hostname   : $(hostname)"
echo

# Uptime & Load
echo "Uptime     : $(uptime -p)"
echo "Load Avg   : $(cat /proc/loadavg | awk '{print $1, $2, $3}')"
echo

# CPU Usage
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)
echo "CPU Usage  : ${CPU_USAGE}%"
echo

# Memory Usage
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')

echo "Memory Usage:"
echo "  Total    : ${MEM_TOTAL} MB"
echo "  Used     : ${MEM_USED} MB"
echo "  Free     : ${MEM_FREE} MB"
echo

# Disk Usage
echo "Disk Usage:"
df -h --total | grep -E "Filesystem|total"
echo

# Top CPU consuming processes
echo "Top 5 CPU Consuming Processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top Memory consuming processes
echo "Top 5 Memory Consuming Processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

echo "=============================="
echo "        END OF REPORT"
echo "=============================="
