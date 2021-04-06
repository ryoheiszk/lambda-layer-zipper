# AWS Lambdaレイヤー用のZipを生成する

## 経緯

LambdaでSeleniumスクレイピングをするために、Selenium/Chromium/ChromeDriverをZipに固めてアップロードする必要があった。

## 必要環境

* Docker
* シェルスクリプトの実行環境

## 仕組み

`build.sh`で、レイヤーZip生成用のDockerイメージ・コンテナの作成と、生成後にイメージ・コンテナを破棄するためのDockerコマンドを発行する。
`Dockerfile`には、Lambdaの実行環境が再現されたコンテナを用意し、必要なブツを揃えるためのコードが記述されている。
ただし、CMD部が長くなったこととや将来的な拡張性を意識して、`docker_cmd.sh`に切り分けた。

## 使用方法

`build.sh`を実行する。
プロジェクトの都合によって、`Dockerfile`や`docker_cmd.sh`を編集する。
