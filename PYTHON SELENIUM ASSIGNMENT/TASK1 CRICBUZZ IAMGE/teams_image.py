
import pandas as pd
import selenium


import os
from selenium import webdriver
from selenium.webdriver.support.ui import Select
import pandas as pd
import time

driverpath=r"C:\Users\merit\Downloads\chromedriver_win32\chromedriver.exe"
driver = webdriver.Chrome(executable_path=driverpath)
driver.get("https://www.cricbuzz.com/cricket-team")
country=driver.find_elements_by_xpath("//body/div[1]/div[2]/div[5]/div[1]")
im= []
for i in country:
    im.append(i.text)
    im2=l[0].split('\n')
    print("Country name:",im2)
img=driver.find_elements_by_xpath("//div[contains(@class,'cb-col cb-col-25')]")
for i,j in zip(img,im2):   
    with open(j+".png","wb") as image:
        image.write(i.screenshot_as_png)
driver.close