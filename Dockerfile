# Stage 1: Build Vue app
FROM node:18 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve Vue app with Nginx
FROM nginx:1.25.1 as prod-stage
COPY --chown=nginx:0 --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80

USER 0 
RUN chmod g+w /app && chmod -R 660 /app/* 
USER nginx

CMD ["nginx", "-g", "daemon off;"]