import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/JsonModels/book_model.dart';
import 'package:sqlite_flutter_crud/JsonModels/cancha_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';
import 'package:sqlite_flutter_crud/Views/cancha_detalle.dart';

class CanchaDetalle2 extends StatefulWidget {
  /*const CanchaDetalle2(int i, {Key? key, required this.canchaId})
      : super(key: key);*/

  final int canchaId;
  final String canchaTitle;

  const CanchaDetalle2(
      {Key? key, required this.canchaId, required this.canchaTitle})
      : super(key: key);

  @override
  State<CanchaDetalle2> createState() => _CanchasState2();
}

class _CanchasState2 extends State<CanchaDetalle2> {
  final db = DatabaseHelper();

  var canchas;

  final canchaId = TextEditingController();
  final userId = TextEditingController();
  final fecha = TextEditingController();
  final horaInicio = TextEditingController();
  final horaFin = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final tipo = TextEditingController();
  final imagen = TextEditingController();
  final keyword = TextEditingController();

  String _selectedItem = '08:00';
  String _selectedItem2 = '08:00';

  final TextEditingController _dateController = TextEditingController();

  static const List<String> horas = <String>['One', 'Two', 'Three', 'Four'];

  @override
  void initState() {
    var handler = DatabaseHelper();
    canchas = handler.getCancha(1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reservar Cancha"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //We need call refresh method after a new cancha is created
            //Now it works properly
            //We will do delete now
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateCancha())).then((value) {
              if (value) {
                //This will be called
                _refresh();
              }
            });*/
          },
          child: const Icon(Icons.add),
        ),
        body: Expanded(
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

                //String dropdownValue = horas.first;

                return SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'lib/assets/cancha2.png',
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            const SizedBox(height: 0),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text('Sport Box'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text('Cancha Tipo B'),
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
                                            prefixIcon:
                                                Icon(Icons.calendar_today),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          readOnly: true,
                                          onTap: () {
                                            _selectDate2();
                                          }),
                                      DropdownButtonFormField<String>(
                                        value: _selectedItem,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedItem = value!;
                                          });
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
                                          setState(() {
                                            _selectedItem2 = value!;
                                          });
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
                                            canchaId: 2,
                                            userId: 1,
                                            fecha: fecha.text,
                                            horaInicio: _selectedItem,
                                            horaFin: _selectedItem2,
                                            createdAt: DateTime.now()
                                                .toIso8601String()))
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
                                              const CanchaDetalle2(
                                                  canchaId: 1,
                                                  canchaTitle: 'titulo')));*/
                                },
                                child: const Text("Reservar",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        )));

                /*List<DateTime> dates = [];
                return SizedBox(
                  //color: Colors.green.shade400,
                  //color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  child: Container(
                    color: const Color.fromARGB(255, 255, 153, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(
                            items[0].canchaImagen,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(items[0].canchaTitle),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(items[0].canchaType),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              margin: const EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(239, 19, 0, 188)),
                              child: CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.range,
                                ),
                                value: dates,
                                onValueChanged: (dates) => dates = dates,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, top: 10, bottom: 20),
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(238, 255, 251, 18)),
                          child: TextButton(
                            onPressed: () {
                              //Navigate to sign up
                              /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CanchaDetalle2(
                                                  canchaId: 1,
                                                  canchaTitle: 'titulo')));*/
                            },
                            child: const Text("Reservar.",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );*/
              }
            },
          ),
        )
        /*Column(
          children: [
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

                    List<DateTime> dates = [];
                    return SizedBox(
                      //color: Colors.green.shade400,
                      //color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: Container(
                        color: const Color.fromARGB(255, 255, 153, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                items[0].canchaImagen,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            const SizedBox(height: 0),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(items[0].canchaTitle),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(items[0].canchaType),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  margin: const EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color.fromARGB(239, 19, 0, 188)),
                                  child: CalendarDatePicker2(
                                    config: CalendarDatePicker2Config(
                                      calendarType:
                                          CalendarDatePicker2Type.range,
                                    ),
                                    value: dates,
                                    onValueChanged: (dates) => dates = dates,
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, top: 10, bottom: 20),
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(238, 255, 251, 18)),
                              child: TextButton(
                                onPressed: () {
                                  //Navigate to sign up
                                  /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CanchaDetalle2(
                                                  canchaId: 1,
                                                  canchaTitle: 'titulo')));*/
                                },
                                child: const Text("Reservar.",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        )*/

        /*Column(
          children: [
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

                    List<DateTime> dates = [];
                    return SizedBox(
                      //color: Colors.green.shade400,
                      //color: Colors.amber,
                      child: Container(
                        color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                items[0].canchaImagen,
                                width: 300,
                              ),
                            ),
                            const SizedBox(height: 0),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(items[0].canchaTitle),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(items[0].canchaType),
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
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20.0, top: 10, bottom: 20),
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xF082BC00)),
                                child: CalendarDatePicker2(
                                  config: CalendarDatePicker2Config(
                                    calendarType: CalendarDatePicker2Type.range,
                                  ),
                                  value: dates,
                                  onValueChanged: (dates) => dates = dates,
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
                                  //Navigate to sign up
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CanchaDetalle2(
                                                  canchaId: 1,
                                                  canchaTitle: 'titulo')));
                                },
                                child: const Text("Reservar",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        )*/
        );
  }

  Future<void> _selectDate2() async {
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
  }
}
