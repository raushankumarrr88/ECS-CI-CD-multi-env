# FROM python:3.9-slim
# WORKDIR /app
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
# COPY . .
# EXPOSE 80
# # ds
# CMD ["python", "app.py"]
# Use the official Nginx image from Docker Hub
FROM nginx:latest

# Copy your static website files to the appropriate location in the Nginx container
COPY index.html /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
