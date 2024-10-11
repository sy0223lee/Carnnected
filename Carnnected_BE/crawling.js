const {Builder, By} = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');
const options = new chrome.Options();
options.addArguments('--incognito');  // 시크릿 모드로
options.excludeSwitches('enable-logging');  // ERROR:device_event_log_impl.cc(214)
options.headless(); // 창 없이

const search = async (keyword, x, y) => { 
  var driver = await new Builder()
    .forBrowser('chrome')
    .setChromeOptions(options)
    .build();

  var urlList = [];
  var elements = [];

  await driver.get('https://www.google.com/maps/search/' + keyword + '/@' + x + ',' + y + ',14z');
  
  await driver.findElements(By.css('a.hfpxzc')).then(function (item){
    for(var value of item){
      // console.log("crawling_value", value);
      value.getAttribute('href').then(function (href){
        // console.log("crawling_href", href);
        urlList.push(href);
      })
    }
  });

  setTimeout(async () => {
    for(var i = 0; i < urlList.length; i++){
        console.log("crawling_urlList", urlList[i]);
        await driver.get(urlList[i]);

          var name = await driver.findElement(By.css('h1.DUwDvf.fontHeadlineLarge span')).getText();
          var address = await driver.findElement(By.css('div.Io6YTe.fontBodyMedium')).getText();
          var type = await driver.findElement(By.xpath('//*[@id="QA0Szd"]/div/div/div[1]/div[2]/div/div[1]/div/div/div[2]/div[1]/div[1]/div[2]/div/div[2]/span[1]/span[1]/button')).getText();
          if(type === "세차장" || type === "셀프 세차장") type = "세차";
          else if(type === "자동차 수리점") type = "정비";
          // console.log("crawling_name-address", name, "-", address);

          elements.push({"type": type,"name": name, "address": address});

    }
    console.log("elements", elements);
    await driver.quit();
  }, 3000);
  return elements;
}

// var fixList = search("자동차 수리점");
// setTimeout(() => {
//   console.log("자동차 수리점: ", fixList);
// }, 45000);

// var washList = search("세차장");
// setTimeout(() => {
//   console.log("세차장: ", washList);
// }, 45000);

// module.exports에 외부에 공유할 API 대입
module.exports = search;