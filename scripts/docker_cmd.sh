#!/bin/sh

# 変数定義
WDIR="lambda_layer"
PACKAGE_PATH="python/lib/python3.6/site-packages"

# 作業ディレクトリをクリア
rm -rf $WDIR

# 依存関係のダウンロード
## 一般ファイル
mkdir -p $WDIR/bin/

### serverless-chromium-amazonlinux
curl -SL https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-37/stable-headless-chromium-amazonlinux-2017-03.zip > headless-chromium.zip
unzip headless-chromium.zip -d $WDIR/bin/
rm headless-chromium.zip

### chromedriver-linux
curl -SL https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip > chromedriver.zip
unzip chromedriver.zip -d $WDIR/bin/
rm chromedriver.zip

## Pythonライブラリ
mkdir -p $WDIR/$PACKAGE_PATH/
pip install -r requirements.txt -t ./$WDIR/$PACKAGE_PATH

# Zip化
cd $WDIR
ls | grep -v -E "*.zip" | xargs zip -r9 lambda_layer.zip
