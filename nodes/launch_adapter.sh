docker build -t simulated-iot-pumps
docker run -it -p 5000:5000 --rm -v "$PWD":/usr/src/app -w /usr/src/app node:10 node server.js
