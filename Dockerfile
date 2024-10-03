# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files to install dependencies
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application files into the container
COPY . .

# Install Chrome and ChromeDriver for Selenium
RUN apt-get update && apt-get install -y wget gnupg2 curl unzip \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') \
    && wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip" \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && ln -sf /usr/local/bin/chromedriver /usr/bin/chromedriver \
    && apt-get clean

# Set environment variables to run Chrome in headless mode
ENV CHROME_BIN=/usr/bin/google-chrome
ENV DISPLAY=:99

# Expose the port the app runs on
EXPOSE 3000

# Start the Node.js application
CMD ["npm", "start"]
