server {
  listen 80;
  server_name _ ${HOST};

  root /var/www/${HOST}/web;

  location / {
    try_files $uri @rewriteapp;
  }

  location @rewriteapp {
    rewrite ^(.*)$ /app_dev.php/$1 last;
  }

  location ~ ^/(app|app_dev)\.php(/|$) {
    fastcgi_pass php-upstream;
    fastcgi_split_path_info ^(.+\.php)(/.*)$;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param HTTPS off;
  }

  error_log /var/log/nginx/${HOST}.error.log;
  access_log /var/log/nginx/${HOST}.access.log;
}