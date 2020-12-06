FROM alpine:latest
 
RUN mkdir -m 777 /web && cd /web \
 && apk add --no-cache ca-certificates curl --virtual .build-deps \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v4.31.3/v2ray-linux-64.zip \
 && unzip v2ray.zip v2ray v2ctl && mv v2ray xcgi \
 && apk del .build-deps \
 && chmod +x /web/xcgi \
 && chgrp -R 0 /web \
 && chmod -R g+rwX /web 
 
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

CMD /entrypoint.sh