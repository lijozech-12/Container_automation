# Use the official Nginx image from Docker Hub as the base image
FROM nginx:alpine

# Remove the default Nginx HTML file
RUN rm -v /usr/share/nginx/html/*

# Copy your HTML file into the Nginx server's document root
COPY weather_forecast.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
