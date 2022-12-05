from datetime import date
import requests
from bs4 import BeautifulSoup
import pandas as pd
#import gspread
#from df2gspread import df2gspread as d2g

url = "https://www.foodcoop.com/produce/"

def update_prices(filename = "test.csv"):
    tables = pd.read_html(url) # Returns list of all tables on page
    t1 = tables[0] # Select table of interest
    t1['date'] = str(date.today())
    t1['item'] = t1['Name'].str.split('$').str[0]#, expand=True)
    t1['price'] = t1['Price'].str[1:].str.split(" ").str[0]
    t1 = t1.drop(columns="Unnamed: 4")
    t1.drop(t1.tail(1).index,inplace=True)
    return t1
#    return t1.values.tolist()

def get_latest_value(sheet):
    start = "A"
    index = 1
    cell_blank = False
    while cell_blank == False:
        value = sheet.acell(start+str(index)).value
        if value == "":
            cell_blank = True
        index += 1
    return start + str(index)

def send_to_sheets():
    gc = gspread.service_account(filename="parkslope-coop-8bd29a8c4f66.json")
    sh = gc.open("ParkSlope coop")
    dataframe = update_prices()
    sh = sh.sheet1
    value = get_latest_value(sh)
    sh.update(dataframe.values.tolist())

if __name__ == "__main__":
    df = update_prices()

    df.to_csv(f'data/{date.today()}-rawprices.csv')


