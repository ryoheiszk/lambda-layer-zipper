#!/bin/sh

WDIR="lambda_layer"
PACKAGE_PATH="python/lib/python3.6/site-packages"

rm -rf $WDIR
mkdir -p $WDIR/bin/
mkdir -p $WDIR/$PACKAGE_PATH/

# serverless-chromium-amazonlinux
curl -SL https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-37/stable-headless-chromium-amazonlinux-2017-03.zip > headless-chromium.zip
unzip headless-chromium.zip -d $WDIR/bin/
rm headless-chromium.zip

# chromedriver-linux
curl -SL https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip > chromedriver.zip
unzip chromedriver.zip -d $WDIR/bin/
rm chromedriver.zip

# Python libs
pip install -r requirements.txt -t ./$WDIR/$PACKAGE_PATH

# Zip layer
cd $WDIR
ls | grep -v -E "*.zip" | xargs zip -r9 lambda_layer.zip
