sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org
sudo apt-get install -y libcurl3 openssl
sudo sed -i '/127.0.1.1/d' /etc/hosts
cd /tmp
sudo wget https://fastdl.mongodb.org/linux/mongodb-linux-arm64-ubuntu1604-4.0.2.tgz
tar -zxvf mongodb-linux-arm64-ubuntu1604-4.0.2.tgz
sudo mkdir /usr/local/mongo-4.0.2 
sudo cp -a mongodb-linux-aarch64-ubuntu1604-4.0.2/. /usr/local/mongo-4.0.2
echo "export PATH=/usr/local/mongo-4.0.2/bin:$PATH" >> ~/.bashrc
sudo sed -i "s/bindIp: .*/bindIp: 0.0.0.0/" /etc/mongod.conf
sudo sed -i "s/#replication:/replication:\n  replSetName: rs_vagrant/" /etc/mongod.conf
sudo ufw allow 27017/tcp
sudo systemctl start mongod
sudo systemctl enable mongod
