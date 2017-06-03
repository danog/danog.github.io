# If you add some configuration command, add the dependancies here
apt-get update
apt-get -y dist-upgrade
apt-get install -y libicu-dev libmcrypt-dev libssl-dev libcurl4-openssl-dev libbz2-dev libxml2-dev libpng-dev libjpeg-dev libedit-dev libgmp-dev openssl bc libbison-dev bison build-essential git-core vim curl pkg-config libgmp-dev autoconf

if [ -f php-script-stuff/ ]; then
    rm -rf php-script-stuff
fi
mkdir php-script-stuff
cd php-script-stuff
if [ -f php-src/ ]; then
    rm -rf php-src/
fi
git clone https://github.com/php/php-src.git php-src
cd php-src
git checkout PHP-7.1.5

./buildconf --force

PHP_TIMEZONE="UTC"

PHP_DIRECTORY="/etc/php7ts"


./configure --prefix=$PHP_DIRECTORY --with-config-file-path=$PHP_DIRECTORY --with-config-file-scan-dir=$PHP_DIRECTORY/conf.d --enable-maintainer-zts --with-curl --with-openssl --with-gd --enable-gd-native-ttf --enable-intl --enable-mbstring --with-mcrypt --with-mysqli=mysqlnd --with-zlib --with-bz2 --enable-exif --with-pdo-mysql=mysqlnd --with-libedit --enable-zip --enable-pdo --enable-pcntl --enable-sockets --enable-mbregex --with-tsrm-pthreads --enable-bcmath --enable-fpm --with-xml --enable-xml --with-fpm-group=pwrtelegram --with-fpm-user=pwrtelegram --enable-ctype --with-gmp

make -j 16
make install
cp -a /etc/php7ts/* /usr/

if [ -f ../pthreads/ ]; then
    rm -rf ../pthreads
fi
git clone https://github.com/SirSnyder/pthreads -b feature/nested_volatiles ../pthreads
cd ../pthreads
phpize
./configure --with-php-config=$PHP_DIRECTORY/bin/php-config
make -j16
make install

if [ -f ../PHP-CPP/ ]; then
    rm -rf ../PHP-CPP
fi

git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP ../PHP-CPP
cd ../PHP-CPP
make -j16
make install


if [ -f ../PrimeModule-ext/ ]; then
    rm -rf ../PrimeModule-ext
fi


git clone https://github.com/danog/PrimeModule-ext ../PrimeModule-ext
cd ../PrimeModule-ext
make -j16
make install



cd ../..
rm -rf php-script-stuff
