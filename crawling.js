const {Builder, By, Capabilities} = require('selenium-webdriver');

const search = async (keyword) => { 
  var driver = await new Builder()
    .withCapabilities(Capabilities.chrome())
    .build();

  var urlList = [];
  var elements = [];

  await driver.get('https://www.google.com/maps/search/' + keyword);
  
  await driver.findElements(By.css('.a4gq8e-aVTXAb-haAclf-jRmmHf-hSRGPd')).then(function (item){
    for(var i = 0; i < item.length; i++){
      item[i].getAttribute('href').then(function (href){
        urlList.push(href);
      })
    }
  });

  setTimeout(async () => {
    for(var i = 0; i < urlList.length; i++){
        //console.log(urlList[i]);
        await driver.get(urlList[i]);

          var name = await driver.findElement(By.css('h1.x3AX1-LfntMc-header-title-title.gm2-headline-5 span')).getText();
          var address = await driver.findElement(By.css('div.QSFF4-text.gm2-body-2')).getText();
          var type = await driver.findElement(By.xpath('//*[@id="pane"]/div/div[1]/div/div/div[2]/div[1]/div[1]/div[2]/div/div[2]/span[1]/span[1]/button')).getText();
          if(type === "세차장") type = "세차";
          else if(type === "자동차 수리점") type = "정비";
          //console.log(name, "-", address);

          elements.push({"type": type,"name": name, "address": address});

    }
    //console.log(elements);
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