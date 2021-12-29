import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recbooks/models/book.dart';

Future getRandomBookData() async {
  var response =
      await http.get(Uri.https('namanshah0008.pythonanywhere.com', 'homepage'));
  var jsonData = jsonDecode(response.body);
  List<Book> randomBooks = [];
  for (var i in jsonData['result']) {
    Book book = Book(i["book_title"], i["book_author"], i["Category"],
        i["Summary"], i["publisher"], i["img_l"], i["rating"]);
    randomBooks.add(book);
  }

  return randomBooks;
  // print(jsonData['result']);
  // return Book(
  //   "Strange but True: A Collection of True Stories from the Files of Fate Magazine",
  //   "Craig Miller",
  //   "Body Mind Spirit",
  //   "From the files of Fate magazine comes this collection of amazing\nfirst-person accounts of paranormal people, miraculous healings, time\ntravel, out-of-body experiences, ghost sightings, and other psychic\nphenomena that are all strange-but ...",
  //   "Gramercy Books",
  //   6);
}
