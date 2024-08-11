import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/JsonModels/cancha_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';

class CreateCancha extends StatefulWidget {
  const CreateCancha({super.key});

  @override
  State<CreateCancha> createState() => _CreateCanchaState();
}

class _CreateCanchaState extends State<CreateCancha> {
  final id = TextEditingController();
  final title = TextEditingController();
  final tipo = TextEditingController();
  final imagen = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create cancha"),
        actions: [
          IconButton(
              onPressed: () {
                //Add Cancha button
                //We should not allow empty data to the database
                if (formKey.currentState!.validate()) {
                  db
                      .createCancha(CanchaModel(
                          canchaId: id.text as int,
                          canchaTitle: title.text,
                          canchaType: tipo.text,
                          canchaImagen: imagen.text,
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
              ],
            ),
          )),
    );
  }
}
