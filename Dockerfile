# Stage 1: Build the React app
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code into the container
COPY . .

# Build the React app for production
RUN npm run build

# Stage 2: Serve the app with NGINX
FROM nginx:stable-alpine

# Copy the build output to NGINX's html directory
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# Expose port 80 to serve the app
EXPOSE 80

# Start NGINX when the container launches
CMD ["nginx", "-g", "daemon off;"]
