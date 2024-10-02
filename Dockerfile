# Use Node.js version 18 as the base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all other files to the working directory
COPY . .

# Expose port 3000 for the React app
EXPOSE 3000

# Command to start the application
CMD ["npm", "start"]
