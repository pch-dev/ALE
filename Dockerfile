# first stage builds vue
FROM node:16 as build-stage
	# Set environment variables
ENV APP_DIR=/app
# Create app directory
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

RUN useradd -ms /bin/bash admin
 
# Install vite
RUN npm install -g vite
 
# Copy the source code
COPY . $APP_DIR
 
# Install dependencies
RUN npm install
 
# Expose port
EXPOSE 3000

RUN chown -R admin:admin /app
RUN chmod 755 /app
USER admin

# Run vite
CMD ["vite", "--port", "3000"]
