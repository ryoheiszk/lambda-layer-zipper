NOW=`date +%s`

docker build -t tmp_$NOW .
docker run --rm --name tmp_$NOW -v "/$(pwd):/var/task" tmp_$NOW
docker image rm tmp_$NOW
