# Virtual machine base on docker which can run Symfony
+ php7-fpm
+ ELK
+ node + yarn
+ nginx

# Create .env file
> HOST=your-local-domain-name

# Add following records to your virtual host file
>
127.0.0.1      your-local-domain-name

# ES configuration
>
* Please check the following document for further information
https://www.elastic.co/guide/en/x-pack/current/security-getting-started.html

* Install Kibana to communicate with Elasticsearch
https://www.elastic.co/downloads/kibana
