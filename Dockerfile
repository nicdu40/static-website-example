FROM nginx:1.21.1
LABEL maintainer="Ulrich"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    apt-get install -y git
RUN rm -Rf /usr/share/nginx/html/*
RUN git clone https://github.com/nicdu40/static-website-example.git /usr/share/nginx/html
CMD sed -i 's/Dimension/Dimension $ENV $IMAGE_TAG/g' /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
