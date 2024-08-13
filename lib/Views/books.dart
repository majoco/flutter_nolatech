import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/JsonModels/book_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';

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
  final fecha = TextEditingController();
  final horaInicio = TextEditingController();
  final horaFin = TextEditingController();
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
        /*floatingActionButton: FloatingActionButton(
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
        ),*/
        body: Column(
          children: [
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
                          var can = '';
                          if (items[index].canchaId == 1) {
                            can = 'Epic Box';
                          } else if (items[index].canchaId == 2) {
                            can = 'Rusty Tenis';
                          } else if (items[index].canchaId == 3) {
                            can = 'Cancha Multiple';
                          }
                          return ListTile(
                            subtitle: Text('${items[index].fecha} ${items[index].horaInicio} ${items[index].horaFin}'),
                            title: Text(can),
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
                                fecha.text = items[index].fecha;
                                horaInicio.text = items[index].horaInicio;
                                horaFin.text = items[index].horaFin;
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
                                                        fecha.text,
                                                        horaInicio.text,
                                                        horaFin.text,
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
                                              controller: fecha,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Fecha de inicio is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Fecha"),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: horaInicio,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Fecha is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Hora inicio"),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: horaFin,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Fecha final is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Hora final"),
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
