# Use Node.js 18 as the base image
FROM node:18

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files to install dependencies
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Install Chrome and ChromeDriver for Selenium
RUN apt-get update && apt-get install -y wget gnupg2 curl unzip \
    && apt-get install -y chromium \
    && CHROME_VERSION=$(chromium --version | grep -oP '\d+\.\d+\.\d+') \
    && wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip" \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && ln -sf /usr/local/bin/chromedriver /usr/bin/chromedriver \
    && apt-get clean

# Expose the port for the React app
EXPOSE 3000

# Default command to run your app
CMD ["npm", "start"]
