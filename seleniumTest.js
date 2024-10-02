const { Builder, By } = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');
require('chromedriver');

// Set Chrome options to run in headless mode
const options = new chrome.Options();
options.addArguments('headless'); // Run Chrome in headless mode
options.addArguments('disable-gpu'); // Applicable only for certain environments

(async function runSeleniumTests() {
    let driver = await new Builder().forBrowser('chrome').setChromeOptions(options).build();
    try {
        // Step 1: Open the React app running locally (you might need to change the URL)
        await driver.get('http://localhost:3000');

        // Step 2: Verify the page title
        let title = await driver.getTitle();
        console.log('Page title is:', title);
        if (title !== 'React App') {
            console.error('Test failed: Incorrect page title');
        }

        // Step 3: Verify that the main heading (h1) contains the correct text
        let heading = await driver.findElement(By.css('h1'));
        let headingText = await heading.getText();
        console.log('Heading text is:', headingText);
        if (headingText !== 'Welcome to React') {
            console.error('Test failed: Incorrect heading text');
        }

        console.log('All tests passed!');
    } catch (err) {
        console.error('Test execution failed:', err);
    } finally {
        // Step 4: Quit the browser
        await driver.quit();
    }
})();
