FROM nginx:1.25.2-alpine3.18
COPY . .
RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/
COPY dist /usr/share/nginx/html
EXPOSE 80