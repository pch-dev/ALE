# Stage 1: Build Vue app
FROM node:18 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve Vue app with Nginx
FROM nginx:1.25.1 as prod-stage

RUN chmod g+rwx /var/cache/nginx /var/run /var/long/nginx

WORKDIR /app

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]