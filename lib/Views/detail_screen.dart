import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/JsonModels/book_model.dart';
import 'package:sqlite_flutter_crud/JsonModels/cancha_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';

class DetailScreen extends StatefulWidget {
  // In the constructor, require a Todo.

  const DetailScreen({super.key, required this.cancha});

  final CanchaModel cancha;

  @override
  Widget build(BuildContext context) {
    final db = DatabaseHelper();
    // Use the Todo to create the UI.
    final fecha = TextEditingController();
    final horaInicio = TextEditingController();
    final horaFin = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final String _selectedItem = '08:00';
    final String _selectedItem2 = '08:00';
    final String _selectedItem3 = '08:00';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservar Cancha"),
      ),
      body: Expanded(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset(
                          cancha.canchaImagen,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      const SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(cancha.canchaTitle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(cancha.canchaType),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text('10 de agosto de 2024'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text('Disponible 7:00 am a 4:00 pm'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text("Establecer Fecha y Hora"),
                      ),
                      Form(
                          //I forgot to specify key
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                /*TextFormField(
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
                                      ),*/
                                TextField(
                                    controller: fecha,
                                    decoration: const InputDecoration(
                                      labelText: 'Fecha',
                                      filled: true,
                                      prefixIcon: Icon(Icons.calendar_today),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () {
                                      //_selectDate();
                                    }),
                                DropdownButtonFormField<String>(
                                  value: _selectedItem,
                                  onChanged: (String? value) {
                                    /*setState(() {
                                      _selectedItem = value!;
                                    });*/
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Select an option',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    "08:00",
                                    "09:00",
                                    "10:00",
                                    "11:00",
                                    "12:00",
                                    "13:00",
                                    "14:00",
                                    "15:00",
                                    "16:00",
                                    "17:00",
                                    "18:00"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                DropdownButtonFormField<String>(
                                  value: _selectedItem2,
                                  onChanged: (String? value) {
                                    /*setState(() {
                                      _selectedItem2 = value!;
                                    });*/
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Select an option',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    "08:00",
                                    "09:00",
                                    "10:00",
                                    "11:00",
                                    "12:00",
                                    "13:00",
                                    "14:00",
                                    "15:00",
                                    "16:00",
                                    "17:00",
                                    "18:00"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )

                                /*TextFormField(
                                        controller: horaInicio,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Hora de inicio is required";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          label: Text("Hora de Inicio"),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: horaFin,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Hora Final is required";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          label: Text("Hora Final"),
                                        ),
                                      ),*/
                              ],
                            ),
                          )),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, top: 10, bottom: 20),
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xF082BC00)),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //print(fecha.text);

                              db
                                  .createBook(BookModel(
                                      canchaId: 1,
                                      userId: 1,
                                      fecha: fecha.text,
                                      horaInicio: _selectedItem,
                                      horaFin: _selectedItem2,
                                      createdAt:
                                          DateTime.now().toIso8601String()))
                                  .whenComplete(() {
                                //When this value is true
                                Navigator.of(context).pop(true);
                              });
                            }

                            //Navigate to sign up
                            /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CanchaDetalle(
                                                  canchaId: 1,
                                                  canchaTitle: 'titulo')));*/
                          },
                          child: const Text("Reservar",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  )))),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  /*Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        fecha.text = picked.toString().split(" ")[0];
      });
    }
  }*/
}
