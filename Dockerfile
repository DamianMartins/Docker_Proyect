FROM nginx:alpine

COPY ./app /usr/share/nginx/html

COPY ./app/script.js /usr/share/nginx/html/script.js

COPY ./app/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./htpasswd /etc/nginx/htpasswd

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

