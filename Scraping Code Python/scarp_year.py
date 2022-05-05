import pandas as pd
import json
import requests
from urllib.request import urlopen
from datetime import datetime


print(datetime.now().strftime("%H:%M:%S"))
df = pd.read_csv(r"C:\Users\Naman Shah\Documents\GitHub\API_final_year_project\processed_data.csv")
df1 = list(set(df['isbn_13'].tolist()))
# df1.dropna(inplace= True)
d_f = pd.read_csv(r"C:\Users\Naman Shah\Desktop\Year List\year_list.csv")
# d_f_1 = d_f['isbn_13'].drop_duplicates()
# d_f_1.dropna(inplace= True)
d_f_1_isbn = d_f['isbn_13'].tolist()

year_list = {}
# isbn_13_list = df1.tolist()
count = 0
print(len(df1))
print(len(d_f_1_isbn))
lll = list(set(df1) - set(d_f_1_isbn))
print(len(lll))

print(len(df1))
try:
    print("Running.\n")
    for i in range(67942,len(isbn_13_list)+1):
        URL = r'https://openlibrary.org/api/volumes/brief/isbn/'+ str(isbn_13_list[i]) + r'.json'
        # print(URL)
        response = urlopen(URL)
        data_json = json.loads(response.read())
        if len(data_json) != 0:
            year_list[isbn_13_list[i]] = data_json['records'][list(data_json['records'].keys())[-1]]['publishDates'][-1]
        else:
            year_list[isbn_13_list[i]] = 'NA'
        count = i
except Exception as e:
    print("Running Stopped due to ", e)
    # print(e)
    print("Number of records scrapped are ",count)
    print("Error")
except KeyboardInterrupt:
    print("Running Stopped due to Keyboard Interrupt")
    print("Number of records scrapped are ",count)
    print("Error")

print(count)
json_object = json.dumps(year_list, indent=4)

# df['year'] = df['isbn_13'].map(year_list)
new_df = pd.DataFrame.from_dict(year_list, orient='index')
new_df.to_csv(r"C:\Users\Naman Shah\Documents\GitHub\API_final_year_project\year_list12.csv")
print("File Saved..")
print(datetime.now().strftime("%H:%M:%S"))