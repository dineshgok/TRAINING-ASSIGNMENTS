import pandas as pd
import selenium

import os
from selenium import webdriver
from selenium.webdriver.support.ui import Select
import pandas as pd
import time

driver= webdriver.Chrome(executable_path=r"C:\Users\Merit\Downloads\chromedriver_win32\chromedriver.exe")
driver.get("https://ai.fmcsa.dot.gov/hhg/Search.asp?ads=a")
driver.maximize_window()
time.sleep(1)
states1=driver.find_elements_by_xpath("//option[contains(text(),'Please select state')]//following::option")
time.sleep(1)
States=[]
writer=pd.ExcelWriter("States.xlsx",engine='xlsxwriter')
for i in states1:
    States.append(i.text)
for j in States[0:10]:
    driver.find_element_by_xpath("//option[contains(text(),'"+j+"')]").click()
    time.sleep(1)
    driver.find_element_by_xpath("//input[@value='Search']").click()
    dt=driver.find_elements_by_xpath("//tr[contains(@scope,'row')]")
    listofcompany= []
    for k in dt:
        listofcompany.append(k.text.split("  "))
    driver.back()
    df=pd.DataFrame(listofcompany,columns=["COMPANY_NAME","HEADQUATERS_LOCATION","COMPANY_TYPE","FLEET_SIZE"])
    df.to_excel(writer,sheet_name=j, index=False)
writer.save()
writer.close()
driver.close()