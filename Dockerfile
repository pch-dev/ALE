# first stage builds vue
FROM node:16 as build-stage

ENV APP_DIR=/app

RUN mkdir -p $APP_DIR

RUN useradd -ms /bin/bash admin
 
RUN chown -R admin:admin /app
RUN chmod 755 /app
USER admin


WORKDIR $APP_DIR


# Install vite
RUN npm install -g vite
 
# Copy the source code
COPY . $APP_DIR
 
# Install dependencies
RUN npm install
 
# Expose port
EXPOSE 3000

# Run vite
CMD ["vite", "--port", "3000"]
