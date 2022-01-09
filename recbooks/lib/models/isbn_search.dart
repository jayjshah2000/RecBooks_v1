import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recbooks/models/book.dart';

Future getISBN13Search(String isbn_13) async {
  var queryParameters = {
    'isbn': isbn_13,
  };
  var response = await http.get(Uri.https(
      'namanshah0008.pythonanywhere.com', 'isbn', queryParameters));
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    List<Book> recommendedBooks = [];
    for (var i in jsonData['result']) {
      Book book = Book(
          i["book_title"],
          i["book_author"],
          i["Category"],
          i["Summary"],
          i["publisher"],
          i["img_l"],
          i["rating"],
          i['isbn_10'],
          i['isbn_13']);
      recommendedBooks.add(book);
    }

    return recommendedBooks;
  } else {
    // print('Request failed with status: ${response.statusCode}.');
    print('Request failed with status');
  }
}