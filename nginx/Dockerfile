FROM debian:jessie

# Get environment variables
ARG HOST
ARG HOST_BLOG

RUN apt-get update && apt-get install -y \
    nginx
RUN mkdir /etc/nginx/templates/


# Copy file templates of cofigurations.
COPY nginx.tpl /etc/nginx/nginx.conf
COPY site.tpl /etc/nginx/sites-available/site.tpl
COPY site-blog.tpl /etc/nginx/sites-available/site-blog.tpl


# Replace variables on templates
RUN sed -e "s/\${HOST}/${HOST}/g" /etc/nginx/sites-available/site.tpl > /etc/nginx/sites-available/${HOST}

RUN sed -e "s/\${HOST_BLOG}/${HOST_BLOG}/g" /etc/nginx/sites-available/site-blog.tpl > /etc/nginx/sites-available/${HOST_BLOG}


# Link cofigurations between sites-available and sites-enabled.
RUN ln -s /etc/nginx/sites-available/${HOST} /etc/nginx/sites-enabled/${HOST}

RUN ln -s /etc/nginx/sites-available/${HOST_BLOG} /etc/nginx/sites-enabled/${HOST_BLOG}


RUN rm /etc/nginx/sites-enabled/default
RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

VOLUME /var/www
WORKDIR /var/www

EXPOSE 80 443 8181

CMD ["nginx"]
