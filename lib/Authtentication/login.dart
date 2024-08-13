import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/Authtentication/signup.dart';
import 'package:sqlite_flutter_crud/JsonModels/users.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';
import 'package:sqlite_flutter_crud/Views/listados.dart';
//import 'package:sqlite_flutter_crud/Views/notes.dart';
import 'package:sqlite_flutter_crud/Views/home.dart';
import 'package:sqlite_flutter_crud/Views/variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //We need two text editing controller

  //TextEditing controller to control the text when we enter into it
  final username = TextEditingController();
  final password = TextEditingController();
  final useremail = TextEditingController();
  final usertelefono = TextEditingController();

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  //Now we should call this function in login button
  login() async {
    var response = await db.login(Users(
        usrName: username.text,
        usrEmail: useremail.text,
        usrPassword: password.text,
        usrTelefono: usertelefono.text));
    if (response != null) {
      //If login is correct, then goto home
      if (!mounted) return;
      print(response[0].usrId);
      setState(() {
        userIdGlobal = response[0].usrId as int;
        userNameGlobal = response[0].usrName;
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Listados()));
    } else {
      //If not, true the bool value to show error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  //We have to create global key for our form
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            /*decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/fondo.png"), fit: BoxFit.cover),
            ),*/
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/login_header.png",
                  width: MediaQuery.of(context).size.width,
                ),
                const Text('Iniciar Sessión',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  //We put all our textfield to a form to be controlled and not allow as empty
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //Username field

                        //Before we show the image, after we copied the image we need to define the location in pubspec.yaml

                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            //color: Colors.deepPurple.withOpacity(.2),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                icon: Icon(Icons.email),
                                border: InputBorder.none,
                                hintText: "Email",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                )),
                          ),
                        ),

                        //Password field
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                controller: password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Contraseña is required";
                                  }
                                  return null;
                                },
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    icon: const Icon(Icons.lock),
                                    border: InputBorder.none,
                                    hintText: "contraseña",
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          //In here we will create a click to show and hide the password a toggle button
                                          setState(() {
                                            //toggle button
                                            isVisible = !isVisible;
                                          });
                                        },
                                        icon: Icon(isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off))),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        //Login button
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xF082bc00)),
                          child: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  //Login method will be here
                                  login();

                                  //Now we have a response from our sqlite method
                                  //We are going to create a user
                                }
                              },
                              child: const Text(
                                "Iniciar sesión",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),

                        //Sign up button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("¿Aun no tienes cuenta?"),
                            TextButton(
                              onPressed: () {
                                //Navigate to sign up
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: const Text('Regístrate',
                                  style: TextStyle(
                                    color: Color(0xFF346BC3),
                                  )),
                            )
                          ],
                        ),

                        TextButton(
                            onPressed: () {
                              //Navigate to sign up
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            },
                            child: const Text("HOME",
                                style: TextStyle(
                                  color: Color(0xFF346BC3),
                                ))),

                        // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                        isLoginTrue
                            ? const Text(
                                "Username or passowrd is incorrect",
                                style: TextStyle(color: Colors.red),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
