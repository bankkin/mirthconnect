# mirthconnect
Automate build Docker container for Mirth Connect + MySQL

Build the image and run with the following command:

container (run by order):
1. mysql
2. mirthconnect
3. phpmyadmin


docker run \
-d \
-v /home/$USER/data/mysql:/var/lib/mysql \
-p 3306:3306 \
-e MYSQL_DATABASE=mirthdb \
-e MYSQL_ROOT_PASSWORD=mirth \
--name mysql \
mysql:5.7 \
--character-set-server=utf8mb4 \
--collation-server=utf8mb4_unicode_ci


docker run \
-d \
-p 8083:8083 \
-p 8443:8443 \
--name mirthconnect \
--link mysql \
YOUR_IMAGE_NAME


docker run \
-d \
-p 8080:80 \
--name phpmyadmin \
--link mysql:db \
phpmyadmin/phpmyadmin

You can launch Mirth Connect Administrator by visiting DOCKER_IP:8083

The default username and password are admin/admin

Enjoy!
