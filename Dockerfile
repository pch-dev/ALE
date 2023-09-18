# first stage builds vue
FROM node:16 as build-stage

USER root
	# Set environment variables
ENV APP_DIR=/app
# Create app directory
RUN mkdir -p $APP_DIR
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
