#/bin/bash

sudo apt-get install unzip

quantisnet-cli stop
systemctl stop quantisnet.service
killall -9 quantisnetd

rm /usr/local/bin/quantis*
rm /usr/local/bin/test_quantis*
rm /usr/local/share/man/man1/dash*
rm /usr/local/lib/libquantis*
rm /usr/local/include/quantisnet*

wget https://github.com/QuantisDev/QuantisNet-Core/releases/download/2.1.3.1/QuantisNetcore-2.1.3.1.-.Linux-Wallets.zip
unzip QuantisNetcore-2.1.3.1.-.Linux-Wallets.zip
rm quantisnetcore-2.1.3-i686-pc-linux-gnu.tar.gz quantisnetcore-2.1.3-arm-linux-gnueabihf.tar.gz
tar -xvzf quantisnetcore-2.1.3-x86_64-linux-gnu.tar.gz

mv quantisnetcore-2.1.3/bin/quantisnet* /usr/local/bin
mv quantisnetcore-2.1.3/bin/test_quantisnet /usr/local/bin
mv quantisnetcore-2.1.3/include/quantis* /usr/local/include
mv quantisnetcore-2.1.3/lib/libquantis* /usr/local/lib
mv quantisnetcore-2.1.3/share/man/man1 /usr/local/share/man
rm -r quantisnetcore-2.1.3
rm quantisnetcore-2.1.3-x86_64-linux-gnu.tar.gz
chmod +x /usr/local/bin/quantisnet*

echo "Do you need to resync the chain? [y/n]"
read DOSETUP

if [[ $DOSETUP =~ "y" ]] ; then
  cd .quantisnetcore
  rm -r chainstate blocks database db.log debug.log fee_estimates.dat governance.dat mempool.dat mncache.dat mnpayments.dat netfulfilled.dat peers.dat
fi

quantisnetd -daemon
sleep 20
quantisnet-cli getinfo
