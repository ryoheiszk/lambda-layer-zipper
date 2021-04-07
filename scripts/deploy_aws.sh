#!/bin/sh

# AWSプロファイルを指定(ローカル:`~/.aws/config`より)
export AWS_PROFILE=default

# 変数定義
layer_zip_name="lambda_layer.zip"
layer_zip_path="./lambda_layer/${layer_zip_name}"
bucket_name="samplescrapeselenium"
layer_name="scrapeset"
compatible_runtimes="python3.6"
lambda_function_name="sample_scrape_selenium"

# S3にレイヤーZipをアップロード
aws s3 cp $layer_zip_path s3://$bucket_name

# S3上のZipファイルからレイヤーを作成(S3ではバージョニングしていない)
aws lambda publish-layer-version \
--layer-name $layer_name \
--description "for aws cli" \
--content S3Bucket=$bucket_name,S3Key=$layer_zip_name,S3ObjectVersion=null \
--compatible-runtimes $compatible_runtimes

# レイヤーの最新バージョンのARNを取得
layer_info=`aws lambda list-layer-versions --layer-name ${layer_name}`
latest_layer_arn=$(echo $layer_info | jq -r '.LayerVersions[0].LayerVersionArn')

# 新しいレイヤーをLambdaに紐付け
aws lambda update-function-configuration \
--function-name $lambda_function_name \
--layers $latest_layer_arn
