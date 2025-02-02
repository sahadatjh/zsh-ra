#!/bin/bash

read -p $'\e[0;33m'"Your Virtual Host : "$'\e[0m' host_name;

read -p $'\e[0;33m'"Project Path : /var/www/"$'\e[0m' project_path

if [ ${#host_name} -gt 0 ] && [ ${#project_path} -gt 0 ]; then

	sudo cat > /etc/nginx/sites-available/$host_name.conf <<-EOF
server {
	listen 80;
	root /var/www/$project_path;
	index index.html index.htm index.php;
	server_name $host_name;
	EOF
	
	sudo echo '

	location / {
		try_files $uri $uri/ /index.php?$query_string;

		autoindex on;
	autoindex_exact_size off;

	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/run/php/php7.4-fpm.sock;
	}

	location ~ /\.ht {
		deny all;
	}
}
	' >> /etc/nginx/sites-available/$host_name.conf

	sudo ln -s /etc/nginx/sites-available/$host_name.conf /etc/nginx/sites-enabled/.
	
	sudo /bin/bash -c "echo -e \"127.0.0.1 $host_name\" >> /etc/hosts"

	sudo /etc/init.d/nginx restart
	
	echo $'\e[1;32m'Your Virtual Host Create Successfully$'\e[0m'
	
else

	echo $'\e[1;31m'Invaild Input$'\e[0m'
	

fi	






