print("===========================================================")
import pandas as pd
import numpy as np
import re
import itertools

# print("Started Running...")
# year_df = pd.read_csv(r"C:\Users\Naman Shah\Desktop\Book2.csv")
# year_df['Year'] = year_df['Year'].astype(int)
# # pattern = r'\d{4}'

# # df['Year'] = df['Date'].apply(lambda x: re.findall(pattern, str(x)))
# # df = df[['isbn_13','Year']]
# # df.to_csv(r"C:\Users\Naman Shah\Desktop\Book2.csv", header = True)
# # print("Completed the extraction of year")
# # print(df.info())
# # new_df = df.set_index('isbn_13').to_dict()
# # print(new_df)
# # year_dict = year_df.set_index('isbn_13').to_dict()
# year_dict = dict(zip(year_df.isbn_13, year_df.Year))
# main_df = pd.read_csv(r"C:\Users\Naman Shah\Documents\GitHub\API_final_year_project\processed_data.csv")
# # print(main_df.head())
# l = dict(list(year_dict.items())[0: 4])
# print(type(year_dict[9780060506063]))
# main_df['year'] = main_df['isbn_13'].map(year_dict)
# main_df.to_csv(r"C:\Users\Naman Shah\Documents\GitHub\API_final_year_project\processed_data_year.csv")

df = pd.read_csv(r"C:\Users\Naman Shah\Desktop\processed_data_year.csv")
print(df.columns)
# print(df.head())