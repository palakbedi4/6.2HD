# Use an official Node.js image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy everything from the current directory into the /app directory inside the container
COPY . .

# Expose port 3000 for the React app
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
