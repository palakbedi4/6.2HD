# Use an official Node.js image as the base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Install Chromium and ChromeDriver for Selenium tests
RUN apt-get update && apt-get install -y wget curl gnupg2 unzip \
    && apt-get install -y chromium-browser \
    && CHROME_VERSION=$(chromium-browser --version | grep -oP '\d+\.\d+\.\d+') \
    && wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip" \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && ln -sf /usr/local/bin/chromedriver /usr/bin/chromedriver \
    && apt-get clean

# Copy the rest of the application
COPY . .

# Expose port 3000 to access the React application
EXPOSE 3000

# Start the React app
CMD ["npm", "start"]
