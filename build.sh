NOW=`date +%s`

# パッケージ類の更新が不要なら以下3行をコメントアウト
docker build -t tmp_$NOW .
docker run --rm --name tmp_$NOW -v "/$(pwd):/var/task" tmp_$NOW
docker image rm tmp_$NOW

./scripts/deploy_aws.sh
