# 1. Top IP Requests
1. Uploaded the file to my test hosting which has Almalinux 9 OS. Put the file into the cPanel home folder.
2. Then, accessed the folder via SSH and used such command:
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -5

Result:
278 98.126.83.64
248 13.212.235.168
153 26.55.70.11
145 3.58.246.203
140 84.147.24.50
# 2. 500 and 200 HTTP codes number check
Command: 
// echo "200: $(grep ' 200 ' access.log | wc -l)" && echo "500: $(grep ' 500 ' access.log | wc -l)"
Result
200: 405
500: 378

405+378= 783

# 3. Number of requests per minute
Command:
awk '{print $4}' access.log | cut -d: -f1-2 | sort | uniq -c
Result:
2000 [11/Aug/2024:09

# 4. Which domain is the most requested
Command:
awk '{print $6}' access.log | sort | uniq -c | sort -nr | head -5

Result:
689 example3.com/page.php
641 example2.com/wp-login.php
347 example3.com/page.html
323 example1.com

# 5. Do all the requests to '/page.php' result in '499' code?
Yes,

Command:
awk '$7 == "/page.php" && $9 != "499"' access.log

Result:
No result

Summary:
If no lines are returned by the command, it means all requests to `/page.php` resulted in a `499` status code.

# ANOMALIES
Take into account the suspicious activity from the IPs:
278 98.126.83.64
248 13.212.235.168
Would check if it is our IPs.

High `499` and `500` Status Codes: These could indicate issues with client connections or server errors that need attention.
Missing `/page.php` Requests: If you expected requests to this page, their absence might be unusual.

Many requests per minute
