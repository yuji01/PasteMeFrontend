FROM nginx:alpine

ENV TZ=Asia/Shanghai
COPY init.sh /temp
RUN cat /docker-entrypoint.sh >> /temp && \
    mv /temp /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh

COPY pastme/* /pasteme_tmp/
RUN mv /pasteme_tmp/conf.d/docker.conf /etc/nginx/conf.d/default.conf && \
    mkdir -p /www/pasteme/usr && \
    mv /pasteme_tmp/css/ /pasteme_tmp/img/ /pasteme_tmp/js/ /www/pasteme/ && \
    mv /pasteme_tmp/favicon.ico /pasteme_tmp/index.html /pasteme_tmp/report.html /www/pasteme/ && \
    mv /pasteme_tmp/usr/config.example.json /config.example.json && \
    rm -rf /pasteme_tmp
EXPOSE 8080
