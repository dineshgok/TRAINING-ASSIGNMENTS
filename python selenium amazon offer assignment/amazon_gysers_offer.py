import selenium
from selenium import webdriver
from selenium.webdriver.support.ui import Select
import pandas as pd
import time
import xlsxwriter
import os

driver= webdriver.Chrome(executable_path=r"C:\Users\Merit\Downloads\chromedriver_win32\chromedriver.exe")
driver.get("https://www.amazon.in/s?k=offer+gysers&ref=nb_sb_noss_2")
driver.maximize_window()
listofproduct=[]
listofofferprice=[]
listoforiginalprice=[]
writer=pd.ExcelWriter("gysers.xlsx",engine='xlsxwriter')
gysersname = driver.find_elements_by_xpath("//h2[@class='a-size-mini a-spacing-none a-color-base s-line-clamp-2']")
for j in gysersname:
    listofproduct.append(j.text)
offerprice= driver.find_elements_by_xpath("//span[@class='a-price-whole']")
for k in offerprice:
    listofofferprice.append(k.text)
originalprice= driver.find_elements_by_xpath("//span[@class='a-price a-text-price']")
for m in originalprice:
    listoforiginalprice.append(m.text)
    time.sleep(2)
    data = pd.DataFrame(list(zip(listofproduct,listofofferprice,listoforiginalprice)),
                    columns = ["productname-gysers","offerprice","originalprice"])
    data.to_excel(writer,sheet_name="offer", index=False)
writer.save()
writer.close()
driver.close()