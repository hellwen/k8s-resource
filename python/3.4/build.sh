
echo "build------------------"

docker build -t 10.0.12.203:32000/dean/python3.4 .

echo "push------------------"

docker push 10.0.12.203:32000/dean/python3.4
