const { Builder, By, Key, until } = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');
const path = require('path');

async function runTest() {
    let service = new chrome.ServiceBuilder('/usr/local/bin/chromedriver').build();
    chrome.setDefaultService(service);

    // Set Chrome options
    let options = new chrome.Options();
    options.addArguments('--headless'); // Run Chrome in headless mode
    options.addArguments('--disable-gpu'); // Disable GPU for headless mode
    options.addArguments('--no-sandbox'); // Necessary for some environments like Docker
    options.addArguments('--disable-dev-shm-usage'); // Overcome limited resource problems

    // Initialize the WebDriver and specify Chrome as the browser
    let driver = await new Builder()
        .forBrowser('chrome')
        .setChromeOptions(options) // Apply the Chrome options
        .build();

    try {
        // Example test: Navigate to Google
        await driver.get('https://www.google.com');
        await driver.findElement(By.name('q')).sendKeys('Selenium', Key.RETURN);
        await driver.wait(until.titleContains('Selenium'), 5000);
        console.log('Test passed! Title contains "Selenium"');
    } catch (err) {
        console.error('Test failed:', err);
    } finally {
        // Quit the WebDriver instance
        await driver.quit();
    }
}

runTest();
