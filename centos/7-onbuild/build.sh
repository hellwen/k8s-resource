
echo "begin build------------------"
docker build -t 10.0.12.203:32000/centos:7-onbuild.001 .

echo "begin push------------------"
docker push 10.0.12.203:32000/centos:7-onbuild.001
