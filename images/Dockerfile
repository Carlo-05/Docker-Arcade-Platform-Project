# Use official Nginx image
FROM nginx:latest

# Set working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove the default nginx static files
RUN rm -rf ./*

# Copy Mario game files into nginx directory
COPY . .

# Expose port 80 for Docker
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

