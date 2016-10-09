
echo "begin build------------------"
docker build -t 10.0.12.203:32000/centos7:0.2 .

echo "begin push------------------"
docker push 10.0.12.203:32000/centos7:0.2
