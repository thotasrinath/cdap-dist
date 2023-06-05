## Docker setup

```bash
sudo docker run -h 172.17.0.2 --ip 172.17.0.2 zookeeper
sudo docker build -t hadoop .
sudo docker run -h 172.17.0.3 --ip 172.17.0.3 -it hadoop /bin/bash
sudo docker build -t cdap-kafka .
sudo docker run -h 172.17.0.4 --ip 172.17.0.4 -it cdap-kafka /bin/bash
sudo docker build -t cdap-master .
sudo docker run -h 172.17.0.5 --ip 172.17.0.5 -it cdap-master /bin/bash
sudo docker build -t cdap-gateway .
sudo docker run -h 172.17.0.6 --ip 172.17.0.6 -it cdap-gateway /bin/bash
sudo docker build -t cdap-ui .
sudo docker run -h 172.17.0.7 --ip 172.17.0.7 -it cdap-ui /bin/bash
```


Kafka properties can be added to cdap-site.xml. They should always start with kafka.server




