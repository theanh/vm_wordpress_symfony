FROM node:7.3

ARG PORT

RUN npm install -g yarn cross-env

# Create app directory
RUN mkdir -p /usr/src/app && mkdir /usr/src/app/front-end
WORKDIR /usr/src/app/front-end

EXPOSE $PORT
CMD [ "npm", "start" ]
