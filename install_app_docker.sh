#!/bin/bash

# Function to install Redash
install_redash() {
    echo "Installing Redash..."
    curl -O https://raw.githubusercontent.com/getredash/setup/master/setup.sh
    chmod +x setup.sh
    sudo ./setup.sh
    echo "Redash installation completed."
}

# Function to install ELK
install_elk() {
    echo "Installing ELK..."
    git clone https://github.com/deviantony/docker-elk.git
    cd docker-elk || exit
    docker-compose up -d
    cd ..
    echo "ELK installation completed."
}

# Function to install Grafana and Prometheus
install_grafana_prometheus() {
    echo "Installing Grafana and Prometheus..."
    git clone https://github.com/stefanprodan/dockprom
    cd dockprom || exit
    docker-compose up -d
    cd ..
    echo "Grafana and Prometheus installation completed."
}

# Function to install MySQL 8 with native password
install_mysql() {
    echo "Installing MySQL 8..."
    docker run -p 3306:3306 --name mysql_80 -e MYSQL_ROOT_PASSWORD=debian -d mysql:8 mysqld --default-authentication-plugin=mysql_native_password
    echo "MySQL 8 installation completed."
}

# Function to install MongoDB
install_mongodb() {
    echo "Installing MongoDB..."
    docker run -d --name mongo -p 27017:27017 -v /tmp/mongodata:/data/db -e MONGO_INITDB_ROOT_USERNAME=debian -e MONGO_INITDB_ROOT_PASSWORD=debian mongo:4.2
    echo "MongoDB installation completed."
}

# Function to install PostgreSQL
install_postgresql() {
    echo "Installing PostgreSQL..."
    docker run --name postgres -e POSTGRES_PASSWORD=debian -p 5432:5432 -d postgres:latest
    echo "PostgreSQL installation completed."
}

# Function to install InfluxDB
install_influxdb() {
    echo "Installing InfluxDB..."
    docker run -p 8086:8086 --name influxdb -e INFLUXDB_DB=defaultdb -e INFLUXDB_ADMIN_USER=admin -e INFLUXDB_ADMIN_PASSWORD=adminpass -e INFLUXDB_USER=user -e INFLUXDB_USER_PASSWORD=userpass -v influxdb:/var/lib/influxdb influxdb:latest
    echo "InfluxDB installation completed."
}

# Function to install Meraki CMX App
install_meraki_cmx() {
    echo "Installing Meraki CMX App..."
    docker run --rm -it -p 4567:4567 -e CMX_SECRET=secret -e CMX_VALIDATOR=validator robertcsapo/cisco-meraki-cmx-api-app
    echo "Meraki CMX App installation completed."
}

# Function to install Apache Kafka
install_kafka() {
    echo "Installing Apache Kafka..."
    curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-kafka/master/docker-compose.yml > docker-compose.yml
    docker-compose up -d
    echo "Apache Kafka installation completed."
}

# Function to install Jenkins
install_jenkins() {
    echo "Installing Jenkins..."
    docker container run -d -p 9102:8080 -v jenkinsvol1:/var/jenkins_home --name jenkins-local jenkins/jenkins:lts
    echo "Jenkins installation completed."
}

# Function to install Hue
install_hue() {
    echo "Installing Hue..."
    docker run -it -p 8888:8888 gethue/hue:latest
    echo "Hue installation completed."
}

# Function to install Odoo
install_odoo() {
    echo "Installing Odoo..."
    curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-odoo/master/docker-compose.yml > docker-compose.yml
    docker-compose up -d
    echo "Odoo installation completed."
}

# Function to install Apache Airflow
install_airflow() {
    echo "Installing Apache Airflow..."
    docker run -d -p 10210:8080 puckel/docker-airflow webserver
    echo "Apache Airflow installation completed."
}

# Function to install Portainer
install_portainer() {
    echo "Installing Portainer..."
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
    echo "Portainer installation completed."
}

# Function to install MongoDB and Mongo Express
install_mongo_express() {
    echo "Installing MongoDB and Mongo Express..."
    docker network create mongo-express-network
    docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=debian -e MONGO_INITDB_ROOT_PASSWORD=debian --name mongodb -v mongodb-data:/data/db --net mongo-express-network mongo:4.2
    docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=debian -e ME_CONFIG_MONGODB_ADMINPASSWORD=debian -e ME_CONFIG_MONGODB_SERVER=mongodb --name mongo-express --net mongo-express-network mongo-express
    echo "MongoDB and Mongo Express installation completed."
}

# Function to install WordPress
install_wordpress() {
    echo "Installing WordPress..."
    docker run -e MYSQL_ROOT_PASSWORD=debian -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest
    docker run -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=debian --name wordpress --link mysql_80:mysql -p 80:80 -v "$PWD/html":/var/www/html -d wordpress
    echo "WordPress installation completed."
}

# Function to install Cube.js
install_cubejs() {
    echo "Installing Cube.js..."
    docker pull cubejs/cube:latest
    docker run -d -p 3000:3000 -p 4000:4000 -e CUBEJS_DB_HOST=172.17.0.1 -e CUBEJS_DB_NAME=meraki -e CUBEJS_DB_USER=root -e CUBEJS_DB_PASS=debian -e CUBEJS_DB_TYPE=mysql -e CUBEJS_API_SECRET=5f0035e3af863433111f4c405f3f7331efd1ca2d5ca419f5f0b3d70a08a8e95b16d76985d92b71f76571a564d933dbf9d2d5c4d343093b609dc11e4decbaa3df -e CUBEJS_DEV_MODE=true -e CUBEJS_REFRESH_WORKER=true -e CUBEJS_WEB_SOCKETS=true -v $(pwd):/cube/conf cubejs/cube:latest
    echo "Cube.js installation completed."
}

# Function to install Spark
install_spark() {
    echo "Installing Spark..."
    git clone https://github.com/big-data-europe/docker-spark.git
    cd docker-spark || exit
    docker-compose up -d
    cd ..
    echo "Spark installation completed."
}

# Function to install Hadoop
install_hadoop() {
    echo "Installing Hadoop..."
    git clone https://github.com/big-data-europe/docker-hadoop.git
    cd docker-hadoop || exit
    docker-compose up -d
    cd ..
    echo "Hadoop installation completed."
}

# Function to install Hadoop-Spark-Workbench
install_hadoop_spark_workbench() {
    echo "Installing Hadoop-Spark-Workbench..."
    git clone https://github.com/big-data-europe/docker-hadoop-spark-workbench.git
    cd docker-hadoop-spark-workbench || exit
    docker-compose up -d
    cd ..
    echo "Hadoop-Spark-Workbench installation completed."
}

# Function to install Metabase
install_metabase() {
    echo "Installing Metabase..."
    sudo docker run -d -p 3000:3000 -v ~/metabase-data:/metabase-data -e "MB_DB_FILE=/metabase-data/metabase.db" --name metabase metabase/metabase
    echo "Metabase installation completed."
}

# Function to install Code Server
install_code_server() {
    echo "Installing Code Server..."
    docker run -d --name=code-server -e PUID=1000 -e PGID=1000 -e TZ=Asia/Jakarta -e PASSWORD=passwd -e SUDO_PASSWORD=passwd -p 443:8443 -v /path/to/appdata/config:/config --restart unless-stopped lscr.io/linuxserver/code-server
    echo "Code Server installation completed."
}

# Function to install Router OS Mikrotik
install_router_os() {
    echo "Installing Router OS Mikrotik..."
    mkdir docker_routeros
    cd docker_routeros || exit
    git clone https://github.com/robiokidenis/Docker-Container-RouterOs.git
    cd Docker-Container-RouterOs || exit
    docker-compose up --build
    docker-compose up -d
    cd ../..
    echo "Router OS Mikrotik installation completed."
}

# Function to install Kali Linux Docker
install_kali_linux_docker() {
    echo "Installing Kali Linux Docker..."
    docker run -t -i kalilinux/kali-rolling /bin/bash
    echo "Kali Linux Docker installation completed."
}

# Main function to run selected installations
install_selected_apps() {
    echo "Select applications to install (separate by space, e.g., 1 2 3):"
    echo "1) Redash"
    echo "2) ELK"
    echo "3) Grafana and Prometheus"
    echo "4) MySQL"
    echo "5) MongoDB"
    echo "6) PostgreSQL"
    echo "7) InfluxDB"
    echo "8) Meraki CMX App"
    echo "9) Kafka"
    echo "10) Jenkins"
    echo "11) Hue"
    echo "12) Odoo"
    echo "13) Airflow"
    echo "14) Portainer"
    echo "15) Mongo Express"
    echo "16) WordPress"
    echo "17) Cube.js"
    echo "18) Spark"
    echo "19) Hadoop"
    echo "20) Hadoop-Spark-Workbench"
    echo "21) Metabase"
    echo "22) Code Server"
    echo "23) Router OS"
    echo "24) Kali Linux Docker"

    read -p "Enter your choices: " choices

    for choice in $choices; do
        case $choice in
            1) install_redash ;;
            2) install_elk ;;
            3) install_grafana_prometheus ;;
            4) install_mysql ;;
            5) install_mongodb ;;
            6) install_postgresql ;;
            7) install_influxdb ;;
            8) install_meraki_cmx ;;
            9) install_kafka ;;
            10) install_jenkins ;;
            11) install_hue ;;
            12) install_odoo ;;
            13) install_airflow ;;
            14) install_portainer ;;
            15) install_mongo_express ;;
            16) install_wordpress ;;
            17) install_cubejs ;;
            18) install_spark ;;
            19) install_hadoop ;;
            20) install_hadoop_spark_workbench ;;
            21) install_metabase ;;
            22) install_code_server ;;
            23) install_router_os ;;
            24) install_kali_linux_docker ;;
            *) echo "Invalid choice: $choice" ;;
        esac
    done
}

# Run the main function
install_selected_apps
