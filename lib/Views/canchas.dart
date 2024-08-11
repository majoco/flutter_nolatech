import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_flutter_crud/JsonModels/cancha_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';
import 'package:sqlite_flutter_crud/Views/create_cancha.dart';

class Canchas extends StatefulWidget {
  const Canchas({super.key});

  @override
  State<Canchas> createState() => _CanchasState();
}

class _CanchasState extends State<Canchas> {
  late DatabaseHelper handler;
  late Future<List<CanchaModel>> canchas;
  final db = DatabaseHelper();

  final title = TextEditingController();
  final tipo = TextEditingController();
  final imagen = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    canchas = handler.getCanchas();

    handler.initDB().whenComplete(() {
      canchas = getAllCanchas();
    });
    super.initState();
  }

  Future<List<CanchaModel>> getAllCanchas() {
    return handler.getCanchas();
  }

  //Search method here
  //First we have to create a method in Database helper class
  Future<List<CanchaModel>> searchCancha() {
    return handler.searchCanchas(keyword.text);
  }

  //Refresh method
  Future<void> _refresh() async {
    setState(() {
      canchas = getAllCanchas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reservas Programadas"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //We need call refresh method after a new cancha is created
            //Now it works properly
            //We will do delete now
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateCancha())).then((value) {
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
                      canchas = searchCancha();
                    });
                  } else {
                    setState(() {
                      canchas = getAllCanchas();
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
              child: FutureBuilder<List<CanchaModel>>(
                future: canchas,
                builder: (BuildContext context,
                    AsyncSnapshot<List<CanchaModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Center(child: Text("No data"));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    final items = snapshot.data ?? <CanchaModel>[];

                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          const imageData = 'lib/assets/cancha1.png';
                          return ListTile(
                            subtitle: Text(DateFormat("yMd").format(
                                DateTime.parse(items[index].createdAt))),
                            title: Text(items[index].canchaTitle),
                            leading: Image.asset(
                                imageData), // Display the image on the left side of the ListTile
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                //We call the delete method in database helper
                                db
                                    .deleteCancha(items[index].canchaId)
                                    .whenComplete(() {
                                  //After success delete , refresh canchas
                                  //Done, next step is update canchas
                                  _refresh();
                                });
                              },
                            ),
                            onTap: () {
                              //When we click on cancha
                              setState(() {
                                final int? canchaId;
                                title.text = items[index].canchaTitle;
                                tipo.text = items[index].canchaType;
                                imagen.text = items[index].canchaImagen;
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
                                                    .updateCancha(
                                                        title.text,
                                                        tipo.text,
                                                        imagen.text,
                                                        items[index].canchaId)
                                                    .whenComplete(() {
                                                  //After update, cancha will refresh
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
                                      title: const Text("Update cancha"),
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            //We need two textfield
                                            TextFormField(
                                              controller: title,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Title is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Title"),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: tipo,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Type is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Type"),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: imagen,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Imagen is required";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Imagen"),
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
