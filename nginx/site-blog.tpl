upstream php {
  server unix:/tmp/php-cgi.socket;
  server php:9000;
}

server {
  listen 8181;

  # SSL configuration
  # listen 443 ssl http2 default_server;
  # listen [::]:443 ssl http2 default_server;
  include snippets/self-signed.conf;
  include snippets/ssl-params.conf;

  server_name _ ${HOST_BLOG};

  root /var/www/${HOST_BLOG};

  index index.php;

  location = /favicon.ico {
    log_not_found off;
    access_log off;
  }

  location = /robots.txt {
    allow all;
    log_not_found off;
    access_log off;
  }

  location / {
    try_files $uri $uri/ /index.php?$args;
  }

  location ~ \.php$ {
    #NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
    include fastcgi.conf;
    fastcgi_intercept_errors on;
    fastcgi_pass php;
    fastcgi_buffers 16 16k;
    fastcgi_buffer_size 32k;
    fastcgi_connect_timeout 300;
    fastcgi_read_timeout 300;
  }

  location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
    expires max;
    log_not_found off;
  }
}
