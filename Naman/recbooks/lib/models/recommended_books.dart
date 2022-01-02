import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recbooks/models/book.dart';

Future getRecommendedBookData1(String title) async {
  var queryParameters = {
    'title': title,
  };
  var response = await http.get(Uri.https(
      'namanshah0008.pythonanywhere.com', 'recommend1', queryParameters));
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    List<Book> recommendedBooks = [];
    for (var i in jsonData['result']) {
      Book book = Book(i["book_title"], i["book_author"], i["Category"],
          i["Summary"], i["publisher"], i["img_l"], i["rating"]);
      recommendedBooks.add(book);
    }

    return recommendedBooks;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future getRecommendedBookData2(String title) async {
  var queryParameters = {
    'title': title,
  };
  var response = await http.get(Uri.https(
      'namanshah0008.pythonanywhere.com', 'recommend3', queryParameters));
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    List<Book> recommendedBooks = [];
    for (var i in jsonData['result']) {
      Book book = Book(i["book_title"], i["book_author"], i["Category"],
          i["Summary"], i["publisher"], i["img_l"], i["rating"]);
      recommendedBooks.add(book);
    }

    return recommendedBooks;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
