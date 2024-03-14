# Use the official Nginx image from Docker Hub as the base image
FROM nginx:alpine

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx config into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Remove the default Nginx HTML file
RUN rm -v /usr/share/nginx/html/*

# Copy your HTML file into the Nginx server's document root
COPY /docs/index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
