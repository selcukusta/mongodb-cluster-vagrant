sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org \
    libcurl3 \
    openssl
sudo sed -i '/127.0.1.1/d' /etc/hosts
sudo sed -i "s/bindIp: .*/bindIp: 0.0.0.0/" /etc/mongod.conf
sudo sed -i "s/#replication:/replication:\n  replSetName: rs_vagrant/" /etc/mongod.conf
sudo systemctl enable mongod
sudo systemctl start mongod