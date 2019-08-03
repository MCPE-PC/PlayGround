#!/bin/bash

cd -P $(dirname "${BASH_SOURCE[0]}")
WORKING_DIR=$(pwd)

PMMP_BRANCH='master'
PHP_DIR="$WORKING_DIR/bin/php7/bin"

(curl -sL https://raw.githubusercontent.com/pmmp/php-build-scripts/master/compile.sh | bash -s - -g -l -n -f) || exit 1
wget https://getcomposer.org/composer.phar -q

git clone --depth=50 https://github.com/pmmp/ext-chunkutils2.git chunkutils2
cd chunkutils2
"$PHP_DIR/phpize"
./configure --with-php-config="$PHP_DIR/php-config" > /dev/null
make > /dev/null
cp modules/chunkutils2.so "$WORKING_DIR/bin/php7/lib"
echo "extension=$WORKING_DIR/bin/php7/lib/chunkutils2.so" >> "$PHP_DIR/php.ini"

cd $WORKING_DIR
rm -rf chunkutils2

git clone --depth=50 https://github.com/pmmp/PocketMine-DevTools.git DevTools
cd DevTools
git checkout $(git describe --tags $(git rev-list --tags --max-count=1))

cd $WORKING_DIR

git clone --depth=50 --branch="$PMMP_BRANCH" https://github.com/pmmp/PocketMine-MP.git PMMP
cd PMMP
git submodule update --init --recursive
"$PHP_DIR/php" "$WORKING_DIR/composer.phar" install || exit 1
"$PHP_DIR/php" -dphar.readonly=0 "$WORKING_DIR/DevTools/src/DevTools/ConsoleScript.php" --make resources,src,vendor --relative ./ --entry src/PocketMine.php --out "$WORKING_DIR/PocketMine-MP.phar"
mv start.sh $WORKING_DIR

cd $WORKING_DIR
rm -rf DevTools PMMP install_data
rm composer.phar install.log
