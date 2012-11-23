#http://www.cyberciti.biz/faq/how-to-find-out-the-ip-address-assigned-to-eth0-and-display-ip-only/
#ifconfig eth2 | grep 'Direc. inet' | cut -d: -f2 | awk '{ print $1}'
#ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

