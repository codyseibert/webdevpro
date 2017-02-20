FROM centos:latest

RUN yum update -y
RUN yum install -y curl
RUN curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
RUN yum install -y nodejs
RUN npm install -g coffee

COPY src /app
COPY node_modules /app/node_modules

ENV NODE_ENV production

EXPOSE 8081

CMD ["coffee", "/app/server.coffee"]
