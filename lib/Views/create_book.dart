import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/JsonModels/book_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';

class CreateBook extends StatefulWidget {
  const CreateBook({super.key});

  @override
  State<CreateBook> createState() => _CreateBookState();
}

class _CreateBookState extends State<CreateBook> {
  final canchaId = TextEditingController();
  final userId = TextEditingController();
  final fecha = TextEditingController();
  final horaInicio = TextEditingController();
  final horaFin = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Reservación"),
        actions: [
          IconButton(
              onPressed: () {
                //Add Book button
                //We should not allow empty data to the database
                if (formKey.currentState!.validate()) {
                  db
                      .createBook(BookModel(
                          canchaId: canchaId.text as int,
                          userId: userId.text as int,
                          fecha: fecha.text,
                          horaInicio: horaInicio.text,
                          horaFin: horaFin.text,
                          createdAt: DateTime.now().toIso8601String()))
                      .whenComplete(() {
                    //When this value is true
                    Navigator.of(context).pop(true);
                  });
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Form(
          //I forgot to specify key
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
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
                    label: Text("Fecha de Inicio"),
                  ),
                ),
                TextFormField(
                  controller: horaInicio,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Fecha de inicio is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Fecha de Inicio"),
                  ),
                ),
                TextFormField(
                  controller: horaFin,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Fecha de fin is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Fecha de fin"),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
