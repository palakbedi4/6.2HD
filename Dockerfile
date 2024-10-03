# Use official Node.js image as the base image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Install Chromium or Google Chrome depending on architecture
RUN apt-get update && apt-get install -y wget gnupg2 curl unzip \
    && if [ "$(dpkg --print-architecture)" = "amd64" ]; then \
         wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
         sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
         apt-get update && apt-get install -y google-chrome-stable && \
         CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') && \
         wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip"; \
     else \
         apt-get install -y chromium && \
         CHROME_VERSION=$(chromium --version | grep -oP '\d+\.\d+\.\d+') && \
         wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip"; \
     fi \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && ln -sf /usr/local/bin/chromedriver /usr/bin/chromedriver \
    && apt-get clean

# Expose port 3000 for the React app
EXPOSE 3000

# Start the React app
CMD ["npm", "start"]
