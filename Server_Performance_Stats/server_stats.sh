#!/bin/bash

echo "####################"
echo "Basic Server Stats"
echo "####################"

echo -e "\n=== Server Uptime ==="
uptime -p

echo -e "\n=== OS version ==="
cat /etc/*-release | head -n 2

echo -e "\n=== Number of Logged in Users ==="
users | wc -l

echo -e "\n=== Number of failed login attempts ==="
sudo lastb | wc -l

echo -e  "\n=== Total CPU usage ==="
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " 100 - $8 "%"}'

echo -e "\n=== Total Memory Usage ==="
free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%) | Free: %sMB (%.2f%%)\n", $3, $2, $3*100/$2, $4, $4*100/$2}'

echo -e "\n=== Total Disk Usage ==="
df -h --total grep 'total' | awk '{printf "Used: %s / %s (%s) | Free: %s\n", $3, $2, $5, $4}'

echo -e "\n=== Top 5 Processes by CPU ==="
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo -e "\n=== Top 5 Proccess by Memory ==="
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
