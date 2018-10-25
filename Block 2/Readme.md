
## Web Application Hacking

# Um beispielsweise die Version des Web Servers herauszufinden
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