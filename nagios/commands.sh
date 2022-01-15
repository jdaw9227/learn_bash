sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
#sudo usermod -a -G nagcmd www-data
cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
tar -zxvf /tmp/nagios-4.4.6.tar.gz
cd /tmp/nagios-4.4.6/
sudo ./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-httpd_conf=/etc/apache2/sites-enabled/
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode
#sudo nano /usr/local/nagios/etc/objects/contacts.cfg
cd /tmp
wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
tar -zxvf /tmp/nagios-plugins-2.3.3.tar.gz
cd /tmp/nagios-plugins-2.3.3/
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make
sudo make install
sudo fuser -k 80/tcp
sudo fuser -k 443/tcp
sudo /etc/init.d/apache2 stop
sudo systemctl restart nginx
sudo service nginx configtest
sudo systemctl enable nagios
sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
  