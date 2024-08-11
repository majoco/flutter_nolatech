import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_flutter_crud/JsonModels/book_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';
import 'package:sqlite_flutter_crud/Views/create_book.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  late DatabaseHelper handler;
  late Future<List<BookModel>> books;
  final db = DatabaseHelper();

  final bookId = TextEditingController();
  final canchaId = TextEditingController();
  final userId = TextEditingController();
  final reservedStart = TextEditingController();
  final reservedEnd = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    books = handler.getBooks();

    handler.initDB().whenComplete(() {
      books = getAllBooks();
    });
    super.initState();
  }

  Future<List<BookModel>> getAllBooks() {
    return handler.getBooks();
  }

  //Search method here
  //First we have to create a method in Database helper class
  Future<List<BookModel>> searchBook() {
    return handler.searchBooks(keyword.text);
  }

  //Refresh method
  Future<void> _refresh() async {
    setState(() {
      books = getAllBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reservaciones"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //We need call refresh method after a new book is created
            //Now it works properly
            //We will do delete now
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CreateBook()))
                .then((value) {
              if (value) {
                //This will be called
                _refresh();
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            //Search Field here
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: keyword,
                onChanged: (value) {
                  //When we type something in textfield
                  if (value.isNotEmpty) {
                    setState(() {
                      books = searchBook();
                    });
                  } else {
                    setState(() {
                      books = getAllBooks();
                    });
                  }
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: "Search"),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<BookModel>>(
                future: books,
                builder: (BuildContext context,
                    AsyncSnapshot<List<BookModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Center(child: Text("No data"));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    final items = snapshot.data ?? <BookModel>[];
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle: Text(DateFormat("yMd").format(
                                DateTime.parse(items[index].createdAt))),
                            title: Text(items[index].canchaId as String),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                //We call the delete method in database helper
                                db
                                    .deleteBook(items[index].bookId!)
                                    .whenComplete(() {
                                  //After success delete , refresh books
                                  //Done, next step is update books
                                  _refresh();
                                });
                              },
                            ),
                            onTap: () {
                              //When we click on book
                              setState(() {
                                final int? bookId;
                                canchaId.text = items[index].canchaId as String;
                                userId.text = items[index].userId as String;
                                reservedStart.text = items[index].reservedStart;
                                reservedEnd.text = items[index].reservedEnd;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                //Now update method
                                                db
                                                    .updateBook(
                                                        canchaId.value as int,
                                                        userId.text as int,
                                                        reservedStart.text,
                                                        reservedEnd.text,
                                                        items[index].bookId
                                                            as int)
                                                    .whenComplete(() {
                                                  //After update, book will refresh
                                                  _refresh();
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: const Text("Update"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                          ],
                                        ),
                                      ],
                                      title: const Text("Update book"),
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            //We need two textfield
                                            TextFormField(
                                              controller: canchaId,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Cancha is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Cancha"),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: userId,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "User is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("User"),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: reservedStart,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Fecha de inicio is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Fecha de inicio"),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: reservedEnd,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Fecha final is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Fecha final"),
                                              ),
                                            ),
                                          ]),
                                    );
                                  });
                            },
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ));
  }
}
