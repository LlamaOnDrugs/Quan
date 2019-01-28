#!/bin/bash
cd ~
quantisnet-cli stop
killall -9 quantisnetd
cd /usr/local/bin
rm quantisnetd quantisnet-cli
wget http://45.76.62.99/files/quantisnetd && chmod +x quantisnetd
wget http://45.76.62.99/files/quantisnet-cli && chmod +x quantisnet-cli
quantisnetd -daemon
