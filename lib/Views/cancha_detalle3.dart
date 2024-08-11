import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/JsonModels/cancha_model.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';

class CanchaDetalle3 extends StatefulWidget {
  /*const CanchaDetalle3(int i, {Key? key, required this.canchaId})
      : super(key: key);*/

  final int canchaId;
  final String canchaTitle;

  const CanchaDetalle3(
      {Key? key, required this.canchaId, required this.canchaTitle})
      : super(key: key);

  @override
  State<CanchaDetalle3> createState() => _CanchasState();
}

class _CanchasState extends State<CanchaDetalle3> {
  final db = DatabaseHelper();

  var canchas;

  final title = TextEditingController();
  final tipo = TextEditingController();
  final imagen = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    var handler = DatabaseHelper();
    canchas = handler.getCancha(3);

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
        body: Column(
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

                    return SizedBox(
                      //color: Colors.green.shade400,
                      //color: Colors.amber,
                      width: 300,
                      child: Container(
                        //color: Colors.red,
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
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text('Cancha Tipo A'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text('10 de agosto de 2024'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text('Disponible 7:00 am a 4:00 pm'),
                            ),
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
                                              const CanchaDetalle3(
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
        ));
  }
}
