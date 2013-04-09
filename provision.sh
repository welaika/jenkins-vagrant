# fix problem reported here https://github.com/mitchellh/vagrant/issues/289
sudo apt-mark hold grub-pc

# upgrade system
apt-get update && sudo apt-get -y upgrade

# install git
apt-get -y install git-core
# install ruby developer packages
apt-get -y install make build-essential libssl-dev libreadline6-dev zlib1g-dev libyaml-dev libsqlite3-dev libssl-dev libc6-dev libpq-dev libcurl4-openssl-dev libksba8 libksba-dev libqtwebkit-dev
# nokogiri requirements
apt-get -y install libxslt-dev libxml2-dev
# headless requirements
apt-get -y install xvfb
# capybara-webkit requirements
apt-get -y install libqt4-dev
# install common DB and tools
apt-get -y install postgresql-9.1 redis-server sqlite3 imagemagick nodejs

rm /etc/postgresql/9.1/main/pg_hba.conf
echo 'local all all trust' >> /etc/postgresql/9.1/main/pg_hba.conf
echo 'host all all 127.0.0.1/32 trust' >> /etc/postgresql/9.1/main/pg_hba.conf
echo 'host all all ::1/128 trust' >> /etc/postgresql/9.1/main/pg_hba.conf
service postgresql restart

# install rbenv and ruby-build
sudo -u vagrant git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.profile
sudo -u vagrant echo 'eval "$(rbenv init -)"' >> /home/vagrant/.profile
sudo -u vagrant git clone git://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

# no rdoc for installed gems
sudo -u vagrant echo 'gem: --no-ri --no-rdoc' >> /home/vagrant/.gemrc

# install required ruby versions
sudo -u vagrant -i rbenv install 2.0.0-p0 && rbenv shell 2.0.0-p0 && gem install bundler && rbenv rehash

