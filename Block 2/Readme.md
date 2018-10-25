
# Web Application Hacking

## Um beispielsweise die Version des Web Servers herauszufinden

nc -vv 192.168.1.20 80
```
(UNKNOWN) [192.168.1.20] 80 (http) open
HEAD
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>400 Bad Request</title>
</head><body>
<h1>Bad Request</h1>
<p>Your browser sent a request that this server could not understand.<br />
</p>
<hr>
<address>Apache/2.2.8 (Ubuntu) DAV/2 Server at metasploitable.localdomain Port 80</address>
</body></html>
 sent 5, rcvd 323
 ```


 ## Gezielt mit NMAP scannen
```
root@kali:~/IFA-SOC# nmap -n -Pn -v -sV --script=http-enum -p 80 192.168.1.20

Starting Nmap 7.70 ( https://nmap.org ) at 2018-10-25 03:44 EDT
NSE: Loaded 44 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 03:44
Completed NSE at 03:44, 0.00s elapsed
Initiating NSE at 03:44
Completed NSE at 03:44, 0.00s elapsed
Initiating ARP Ping Scan at 03:44
Scanning 192.168.1.20 [1 port]
Completed ARP Ping Scan at 03:44, 0.04s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 03:44
Scanning 192.168.1.20 [1 port]
Discovered open port 80/tcp on 192.168.1.20
Completed SYN Stealth Scan at 03:44, 0.03s elapsed (1 total ports)
Initiating Service scan at 03:44
Scanning 1 service on 192.168.1.20
Stats: 0:00:07 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
Service scan Timing: About 0.00% done
Completed Service scan at 03:44, 6.09s elapsed (1 service on 1 host)
NSE: Script scanning 192.168.1.20.
Initiating NSE at 03:44
Completed NSE at 03:44, 2.49s elapsed
Initiating NSE at 03:44
Completed NSE at 03:44, 0.00s elapsed
Nmap scan report for 192.168.1.20
Host is up (0.0011s latency).

PORT   STATE SERVICE VERSION
80/tcp open  http    Apache httpd 2.2.8 ((Ubuntu) DAV/2)
| http-enum: 
|   /tikiwiki/: Tikiwiki
|   /test/: Test page
|   /phpinfo.php: Possible information file
|   /phpMyAdmin/: phpMyAdmin
|   /doc/: Potentially interesting directory w/ listing on 'apache/2.2.8 (ubuntu) dav/2'
|   /icons/: Potentially interesting folder w/ directory listing
|_  /index/: Potentially interesting folder
|_http-server-header: Apache/2.2.8 (Ubuntu) DAV/2
MAC Address: 08:00:27:62:87:85 (Oracle VirtualBox virtual NIC)

NSE: Script Post-scanning.
Initiating NSE at 03:44
Completed NSE at 03:44, 0.00s elapsed
Initiating NSE at 03:44
Completed NSE at 03:44, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 10.08 seconds
           Raw packets sent: 2 (72B) | Rcvd: 2 (72B)
root@kali:~/IFA-SOC# 
```
