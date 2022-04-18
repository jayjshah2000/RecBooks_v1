# from flask import Flask, jsonify
# import pandas as pd
# import numpy as np
# from requests import request
# from flask import request
# import os
# import re
# import nltk
# import requests
# import warnings
# import pandas as pd
# import numpy as np
# import matplotlib.pyplot as plt

# import json
# warnings.filterwarnings('ignore')
# from nltk.corpus import stopwords
# nltk.download("stopwords")
# from sklearn.feature_extraction.text import CountVectorizer
# from sklearn.metrics.pairwise import cosine_similarity

'''
A few book titles to test the API
Wild Animus
Fahrenheit 451
The Street Lawyer

The Testament
Harry Potter and the Order of the Phoenix (Book 5)

Snow Falling on Cedars
Harry Potter and the Order of the Phoenix (Book 5)
'''

'''
Please the file path of the csv as only the file name with extension to make it work with the API
Pythonanywhere does not have local files path system

'''


from flask import Flask,jsonify
import pandas as pd
import numpy as np
from requests import request
from flask import request
import os
import re
import nltk
import requests
import warnings
import pandas as pd
import numpy as np

import json
warnings.filterwarnings('ignore')
from nltk.corpus import stopwords
nltk.download("stopwords")
import json
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

'''
A few book titles to test the API
Decision in Normandy
Wild Animus
I'll Be Seeing You
Shabanu: Daughter of the Wind (Border Trilogy)
'''


app = Flask(__name__)
app.config["DEBUG"] = True
books = pd.read_csv(r"processed_data.csv")
books['isbn_13'] = books['isbn_13'].apply(str)
books.dropna(inplace=True)
books.reset_index(drop=True, inplace=True)
books.drop(index=books[books['Category'] == '9'].index, inplace=True) #remove 9 in category
books.drop(index=books[books['rating'] == 0].index, inplace=True) #remove 0 in rating
books['Category'] = books['Category'].apply(lambda x: re.sub('[\W_]+',' ',x).strip())


# # df = pd.read_csv("processed_data.csv")
# # books = pd.read_csv(r"processed_data.csv")
# # books['isbn_13'] = books['isbn_13'].apply(str)
# books = pd.read_csv(r"processed_data.csv")
# # books['isbn_13'] = books['isbn_13'].fillna(0)
# # books['isbn_13'] = books['isbn_13'].apply(int)
# books['isbn_13'] = books['isbn_13'].apply(str)
# books.dropna(inplace=True)
# books.reset_index(drop=True, inplace=True)
# books.drop(index=books[books['Category'] == '9'].index, inplace=True) #remove 9 in category
# books.drop(index=books[books['rating'] == 0].index, inplace=True) #remove 0 in rating
# books['Category'] = books['Category'].apply(lambda x: re.sub('[\W_]+',' ',x).strip())
# app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def welcome():
    name = request.args.get("title")
    global books
    # books = pd.read_csv("processed_data.csv")
    final_df = books.loc[books['book_title'] == name]
    print(books.head())
    return final_df.to_html()
    # return "Hello World! Naman here."

@app.route('/homepage')
def homepage():
    global books
    final_df = books.sort_values(by = 'year', ascending = False)
    final_df.reset_index(drop=True, inplace=True)
    final_df.drop(columns=['user_id', 'book_'], inplace=True)
    final_df.drop_duplicates(inplace=True)
    final_df = final_df.head(10)
    jdata = '{"result":'+final_df.to_json(orient='records')+'}'
    return jsonify(json.loads(jdata))




@app.route('/search')
def search():
    name = request.args.get("title")
    global books
    final_df = books.loc[books['book_title'] == name]
    final_df.reset_index(drop=True, inplace=True)
    final_df.drop(columns=['user_id', 'book_'], inplace=True)
    final_df.drop_duplicates('isbn_13',inplace=True)
    jdata = '{"result":'+final_df.to_json(orient='records')+'}'
    print(final_df)
    # return final_df.to_html()
    return jsonify(json.loads(jdata))
    # print(final_df.head())
    # return final_df.to_html()


# Universal Search
@app.route('/universalsearch/', methods=['GET', 'POST'])
def universal_search():
    isbn = str(request.args.get("isbn"))
    book_title = str(request.args.get("title"))
    category = str(request.args.get("category"))
    author = str(request.args.get("author"))

    global books
    # final_df = books[(books['isbn_13'] == isbn) | (books['book_title'] == book_title) | (books['Category'] == category) | (books['book_author'] == author)]
    final_df = books[books['isbn_13'] == isbn]
    final_df = pd.concat([final_df, books[books['isbn_13'] == isbn]], ignore_index = True)
    final_df = pd.concat([final_df, books[books['isbn_10'] == isbn]], ignore_index = True)
    final_df = books[books['book_title'] == book_title]
    #  or (books['isbn_13'] == isbn) or (books['isbn_10'] == isbn) or (books['Category'] == category) or (books['book_author'] == author)
    print(type(final_df))
    final_df= pd.concat([final_df,books[books['book_author'] == author]], ignore_index = True)
    final_df = pd.concat([final_df, books[books['Category'] == category]], ignore_index = True)
    print(final_df.head())
    final_df.drop(columns=['user_id', 'book_'], inplace=True)
    final_df.drop_duplicates(subset=['book_title'],inplace=True)
    jdata = '{"result":'+final_df[:20].to_json(orient='records')+'}'
    return jsonify(json.loads(jdata))

# ISBN Search
@app.route('/isbn/', methods=['GET', 'POST'])
def isbn_search():
    isbn = str(request.args.get("isbn"))
    global books
    if len(isbn) == 10:
        final_df = books[books['isbn_10'] == isbn]
        final_df.drop(columns=['user_id', 'book_'], inplace=True)
        final_df.drop_duplicates(subset=['book_title'],inplace=True)
        jdata = '{"result":'+final_df.to_json(orient='records')+'}'
        return jsonify(json.loads(jdata))
    elif len(isbn) == 13:
        final_df = books[books['isbn_13'] == isbn]
        final_df.drop(columns=['user_id', 'book_'], inplace=True)
        final_df.drop_duplicates(subset=['book_title'],inplace=True)
        jdata = '{"result":'+final_df.to_json(orient='records')+'}'
        return jsonify(json.loads(jdata))
    else:
        print("Invalid ISBN")
        return jsonify(json.loads('{"result":0}'))
    return jsonify(json.loads('{"result":0}'))



@app.route('/recommend/', methods=['GET', 'POST'])
def recommend():
    title=request.args.get("title")
    global books
    # books = pd.read_csv(r"processed_data.csv")
    df = books.copy()
    # df.dropna(inplace=True)
    # df.reset_index(drop=True, inplace=True)

    # df.drop(columns = ['img_l'],axis=1,inplace = True) #remove useless cols
    # df.drop(index=df[df['Category'] == '9'].index, inplace=True) #remove 9 in category
    # df.drop(index=df[df['rating'] == 0].index, inplace=True) #remove 0 in rating
    # df['Category'] = df['Category'].apply(lambda x: re.sub('[\W_]+',' ',x).strip())

    book_title = str(title)
    if book_title in df['book_title'].values:
        rating_counts = pd.DataFrame(df['book_title'].value_counts())
        rare_books = rating_counts[rating_counts['book_title'] <= 180].index
        common_books = df[~df['book_title'].isin(rare_books)]

        if book_title in rare_books:
            random = pd.Series(common_books['book_title'].unique()).sample(2).values
            return 'There are no recommendations for this book.'
            # print('There are no recommendations for this book')
            # print('Try: \n')
            # print('{}'.format(random[0]),'\n')
            # print('{}'.format(random[1]),'\n')
        else:
            user_book_df = common_books.pivot_table(index=['user_id'],columns=['book_title'],values='rating')

            book = user_book_df[book_title]
            recom_data = pd.DataFrame(user_book_df.corrwith(book).sort_values(ascending=False)).reset_index(drop=False)

            if book_title in [book for book in recom_data['book_title']]:
                recom_data = recom_data.drop(recom_data[recom_data['book_title'] == book_title].index[0])

            low_rating = []
            for i in recom_data['book_title']:
                if df[df['book_title'] == i]['rating'].mean() < 5:
                    low_rating.append(i)

            if recom_data.shape[0] - len(low_rating) > 5:
                recom_data = recom_data[~recom_data['book_title'].isin(low_rating)]

            recom_data = recom_data[0:5]
            recom_data.columns = ['book_title','corr']
            final_df = books[books['book_title'].isin(recom_data['book_title'])]

            # fig, axs = plt.subplots(1, 5,figsize=(18,5))
            # fig.suptitle('You may also like these books', size = 22)
            final_df.drop(columns = ['user_id','book_'],axis=1,inplace = True) #remove useless cols
            final_df = final_df.drop_duplicates(subset='book_title', keep='first', inplace=False)
            print(final_df)
            return final_df.to_html()
    else:
        return 'Cant find book in dataset, please check spelling'

    return "0"






@app.route('/recommend1/', methods=['GET', 'POST'])
def recommend1():
    title=request.args.get("title")
    global books
    # books = pd.read_csv(r"processed_data.csv")
    df = books.copy()
    # df.dropna(inplace=True)
    # df.reset_index(drop=True, inplace=True)

    # df.drop(columns = ['img_l'],axis=1,inplace = True) #remove useless cols
    # df.drop(index=df[df['Category'] == '9'].index, inplace=True) #remove 9 in category
    # df.drop(index=df[df['rating'] == 0].index, inplace=True) #remove 0 in rating
    # df['Category'] = df['Category'].apply(lambda x: re.sub('[\W_]+',' ',x).strip())

    book_title = str(title)
    if book_title in df['book_title'].values:
        rating_counts = pd.DataFrame(df['book_title'].value_counts())
        rare_books = rating_counts[rating_counts['book_title'] <= 70].index
        common_books = df[~df['book_title'].isin(rare_books)]

        if book_title in rare_books:
            random_books = pd.Series(common_books['book_title'].unique()).sample(2).values
            # print(random_books)
            final_df = books[books['book_title'].isin(random_books)]
            final_df.drop(columns = ['user_id','book_'],axis=1,inplace = True) #remove useless cols
            final_df = final_df.drop_duplicates(subset='book_title', keep='first', inplace=False)
            jdata = '{"result":'+final_df.to_json(orient='records')+'}'
            return jsonify(json.loads(jdata))
            # print('There are no recommendations for this book')
            # print('Try: \n')
            # print('{}'.format(random[0]),'\n')
            # print('{}'.format(random[1]),'\n')
        else:
            user_book_df = common_books.pivot_table(index=['user_id'],columns=['book_title'],values='rating')

            book = user_book_df[book_title]
            recom_data = pd.DataFrame(user_book_df.corrwith(book).sort_values(ascending=False)).reset_index(drop=False)

            if book_title in [book for book in recom_data['book_title']]:
                recom_data = recom_data.drop(recom_data[recom_data['book_title'] == book_title].index[0])

            low_rating = []
            for i in recom_data['book_title']:
                if df[df['book_title'] == i]['rating'].mean() < 5:
                    low_rating.append(i)

            if recom_data.shape[0] - len(low_rating) > 5:
                recom_data = recom_data[~recom_data['book_title'].isin(low_rating)]

            recom_data = recom_data[0:5]
            recom_data.columns = ['book_title','corr']
            final_df = books[books['book_title'].isin(recom_data['book_title'])]

            # fig, axs = plt.subplots(1, 5,figsize=(18,5))
            # fig.suptitle('You may also like these books', size = 22)
            final_df.drop(columns = ['user_id','book_'],axis=1,inplace = True) #remove useless cols
            final_df = final_df.drop_duplicates(subset='book_title', keep='first', inplace=False)
            jdata = '{"result":'+final_df.to_json(orient='records')+'}'
            # new_df = pd.DataFrame()
            # new_df['result'] = final_df
            # print(final_df)
            return jsonify(json.loads(jdata))
    else:
        return jsonify(json.loads('{"result":"Cant find book in dataset, please check spelling"}'))

    return jsonify(json.loads('{"result":"0"}'))



# Content Based recommender
@app.route('/recommend2/', methods=['GET', 'POST'])
def content_based_recommender():
    title=request.args.get("title")
    global books
    # books = pd.read_csv(r"processed_data.csv")
    df = books.copy()
    # df.dropna(inplace=True)
    # df.reset_index(drop=True, inplace=True)

    # # df.drop(columns = ['img_l'],axis=1,inplace = True) #remove useless cols
    # df.drop(index=df[df['Category'] == '9'].index, inplace=True) #remove 9 in category
    # df.drop(index=df[df['rating'] == 0].index, inplace=True) #remove 0 in rating
    # df['Category'] = df['Category'].apply(lambda x: re.sub('[\W_]+',' ',x).strip())

    book_title = str(title)
    if book_title in df['book_title'].values:
        rating_counts = pd.DataFrame(df['book_title'].value_counts())
        rare_books = rating_counts[rating_counts['book_title'] <= 70].index
        common_books = df[~df['book_title'].isin(rare_books)]

        if book_title in rare_books:
            # random = pd.Series(common_books['book_title'].unique()).sample(2).values
            # # print('There are no recommendations for this book')
            # # print('Try: \n')
            # # print('{}'.format(random[0]),'\n')
            # # print('{}'.format(random[1]),'\n')
            # return jsonify(json.loads('{"result":"There are no recommendations for this book."}'))
            random_books = pd.Series(common_books['book_title'].unique()).sample(2).values
            # print(random_books)
            final_df = books[books['book_title'].isin(random_books)]
            final_df.drop(columns = ['user_id','book_'],axis=1,inplace = True) #remove useless cols
            final_df = final_df.drop_duplicates(subset='book_title', keep='first', inplace=False)
            jdata = '{"result":'+final_df.to_json(orient='records')+'}'
            return jsonify(json.loads(jdata))

        else:
            common_books = common_books.drop_duplicates(subset=['book_title'])
            common_books.reset_index(inplace= True)
            common_books['index'] = [i for i in range(common_books.shape[0])]
            target_cols = ['book_title','book_author','publisher','Category']
            common_books['combined_features'] = [' '.join(common_books[target_cols].iloc[i,].values) for i in range(common_books[target_cols].shape[0])]
            cv = CountVectorizer()
            count_matrix = cv.fit_transform(common_books['combined_features'])
            cosine_sim = cosine_similarity(count_matrix)
            index = common_books[common_books['book_title'] == book_title]['index'].values[0]
            sim_books = list(enumerate(cosine_sim[index]))
            sorted_sim_books = sorted(sim_books,key=lambda x:x[1],reverse=True)[1:6]

            books = []
            for i in range(len(sorted_sim_books)):
                books.append(common_books[common_books['index'] == sorted_sim_books[i][0]]['book_title'].item())

            # print("\n\n\n\n", books, "\n\n\n\n", "\n\n\n\n", sorted_sim_books, "\n\n\n\n", "\n\n\n\n", common_books, "\n\n\n\n")
            final_df = df[df['book_title'].isin(books)]
            final_df.drop(columns = ['user_id','book_'],axis=1,inplace = True) #remove useless cols
            final_df = final_df.drop_duplicates(subset='book_title', keep='first', inplace=False)
            # print(final_df)
            # print("\n\n\n\n", final_df, "\n\n\n\n")
            jdata = '{"result":'+final_df.to_json(orient='records')+'}'
            # new_df = pd.DataFrame()
            # new_df['result'] = final_df
            # print(final_df)
            return jsonify(json.loads(jdata))
    else:
        return jsonify(json.loads('{"result":"Cant find book in dataset, please check spelling"}'))

    return jsonify(json.loads('{"result":"0"}'))


# Content Based recommender
@app.route('/recommend3/', methods=['GET', 'POST'])
def content_based_recommender1():
    title=request.args.get("title")
    global books
    # books = pd.read_csv(r"processed_data.csv")
    df = books.copy()
    # df.dropna(inplace=True)
    # df.reset_index(drop=True, inplace=True)

    # # df.drop(columns = ['img_l'],axis=1,inplace = True) #remove useless cols
    # df.drop(index=df[df['Category'] == '9'].index, inplace=True) #remove 9 in category
    # df.drop(index=df[df['rating'] == 0].index, inplace=True) #remove 0 in rating
    # df['Category'] = df['Category'].apply(lambda x: re.sub('[\W_]+',' ',x).strip())

    book_title = str(title)
    if book_title in df['book_title'].values:
        rating_counts = pd.DataFrame(df['book_title'].value_counts())
        rare_books = rating_counts[rating_counts['book_title'] <= 15].index
        common_books = df[~df['book_title'].isin(rare_books)]

        if book_title in rare_books:
            random_books = pd.Series(common_books['book_title'].unique()).sample(2).values
            final_df = books[books['book_title'].isin(random_books)]
            final_df.drop(columns = ['user_id','book_'],axis=1,inplace = True) #remove useless cols
            final_df = final_df.drop_duplicates(subset='book_title', keep='first', inplace=False)
            jdata = '{"result":'+final_df.to_json(orient='records')+'}'
            return jsonify(json.loads(jdata))

        else:
            print()
            common_books = common_books.drop_duplicates(subset=['book_title'])
            common_books.reset_index(inplace= True)
            common_books['index'] = [i for i in range(common_books.shape[0])]
            target_cols = ['book_title','book_author','publisher','Category']
            common_books['combined_features'] = [' '.join(common_books[target_cols].iloc[i,].values) for i in range(common_books[target_cols].shape[0])]
            cv = CountVectorizer()
            count_matrix = cv.fit_transform(common_books['combined_features'])
            cosine_sim = cosine_similarity(count_matrix)
            index = common_books[common_books['book_title'] == book_title]['index'].values[0]
            sim_books = list(enumerate(cosine_sim[index]))
            sorted_sim_books = sorted(sim_books,key=lambda x:x[1],reverse=True)[1:6]

            books = []
            for i in range(len(sorted_sim_books)):
                books.append(common_books[common_books['index'] == sorted_sim_books[i][0]]['book_title'].item())
            # print("\n\n\n\n", books, "\n\n\n\n", "\n\n\n\n", sorted_sim_books, "\n\n\n\n", "\n\n\n\n", common_books, "\n\n\n\n")
            final_df = df[df['book_title'].isin(books)]
            final_df.drop(columns = ['user_id','book_'],axis=1,inplace = True) #remove useless cols
            final_df = final_df.drop_duplicates(subset='book_title', keep='first', inplace=False)
            # print(final_df)
            # print("\n\n\n\n", final_df, "\n\n\n\n")
            jdata = '{"result":'+final_df.to_json(orient='records')+'}'
            # new_df = pd.DataFrame()
            # new_df['result'] = final_df
            # print(final_df)
            return jsonify(json.loads(jdata))
    else:
        return jsonify(json.loads('{"result":"Cant find book in dataset, please check spelling"}'))

    return jsonify(json.loads('{"result":"0"}'))


if __name__ == '__main__':
    app.run()