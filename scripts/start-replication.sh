#!/bin/bash
echo "Waiting MongoDB to launch on 27017..."
while ! nc -z $1 27017; do
  sleep 0.1
done
echo "MongoDB is launched!"
mongo $1:27017/admin $2