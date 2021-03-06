
# If you add some configuration command, add the dependencies here
apt-get update
apt-get -y dist-upgrade
apt-get install -y binutils-dev libicu-dev libmcrypt-dev libssl-dev libcurl4-openssl-dev libbz2-dev libxml2-dev libpng-dev libjpeg-dev libedit-dev libgmp-dev openssl bc libbison-dev bison build-essential git-core vim curl pkg-config libgmp-dev autoconf libopus-dev libreadline-dev libncurses5-dev
apt-get purge -y 'php*'
if [ -d php-script-stuff/ ]; then
    rm -rf php-script-stuff
fi
mkdir php-script-stuff
cd php-script-stuff
if [ -d php-src/ ]; then
    rm -rf php-src/
fi
git clone https://github.com/php/php-src.git php-src
cd php-src
git checkout PHP-7.1.9

./buildconf --force

PHP_TIMEZONE="UTC"

PHP_DIRECTORY="/etc/php7ts"


./configure --prefix=$PHP_DIRECTORY --with-config-file-path=$PHP_DIRECTORY --with-config-file-scan-dir=$PHP_DIRECTORY/conf.d --enable-maintainer-zts --with-curl --with-openssl --with-gd --enable-gd-native-ttf --enable-intl --enable-mbstring --with-mcrypt --with-mysqli=mysqlnd --with-zlib --with-bz2 --enable-exif --with-pdo-mysql=mysqlnd --with-libedit --enable-zip --enable-pdo --enable-pcntl --enable-sockets --enable-mbregex --with-tsrm-pthreads --enable-bcmath --enable-fpm --with-xml --enable-xml --with-fpm-group=pwrtelegram --with-fpm-user=pwrtelegram --enable-ctype --with-gmp

make -j 16
make install
cp -a /etc/php7ts/* /usr/

[ ! -d $PHP_DIRECTORY/conf.d ] && mkdir $PHP_DIRECTORY/conf.d

if [ -d ../pthreads/ ]; then
    rm -rf ../pthreads
fi
git clone https://github.com/SirSnyder/pthreads -b feature/nested_volatiles ../pthreads
cd ../pthreads
phpize
./configure --with-php-config=$PHP_DIRECTORY/bin/php-config
make -j$(nproc)
make install

if [ -d ../PHP-CPP/ ]; then
    rm -rf ../PHP-CPP
fi

git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP ../PHP-CPP
cd ../PHP-CPP
make -j$(nproc)
make install


if [ -d ../PrimeModule-ext/ ]; then
    rm -rf ../PrimeModule-ext
fi


git clone https://github.com/danog/PrimeModule-ext ../PrimeModule-ext
cd ../PrimeModule-ext
make -j$(nproc)
make install

git clone https://github.com/openssl/openssl ../openssl
cd ../openssl
git checkout OpenSSL_1_0_2-stable
CFLAGS=-fPIC ./config shared --prefix=/usr/local/ssl && make -j$(nproc) all && make install_sw

git clone --recursive https://github.com/danog/php-libtgvoip ../php-libtgvoip
cd ../php-libtgvoip
make -j$(nproc)
make install

cd ..

LUA_DOWNLOAD_URL=http://www.lua.org/ftp/
LUA_VERSION=5.2.1
LUA_GET_URL=${LUA_DOWNLOAD_URL}lua-${LUA_VERSION}.tar.gz
PHP_LUA_DOWNLOAD_URL=http://pecl.php.net/get/lua-2.0.3.tgz
PHP_VERSION=$(php-config --phpapi)


wget $LUA_GET_URL $PHP_LUA_DOWNLOAD_URL
tar -xf lua-${LUA_VERSION}.tar.gz
tar -xf lua-2.0.3.tgz

cd lua-${LUA_VERSION}
sed -i 's/CFLAGS= -O2/CFLAGS= -fPIC -O2/g' src/Makefile
make linux test
make linux install
cd ..

cd lua-2.0.3
phpize
autoreconf -f -i
./configure --with-lua=/usr/local
make
make install
cd ../..
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")
if [ "$ACTUAL_SIGNATURE" != "$EXPECTED_SIGNATURE" ]
then
    echo 'ERROR: Invalid installer signature'
    rm -rf composer-setup.php
else
    php composer-setup.php --filename=composer --install-dir=/usr/bin
    rm -rf composer-setup.php
fi
rm -rf php-script-stuff
