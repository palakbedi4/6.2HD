# Base image: Node.js 18
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker layer caching
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port the app runs on (if your app uses a different port, modify this)
EXPOSE 3000

# Command to start your app
CMD ["npm", "start"]
