import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/Authtentication/login.dart';
import 'package:sqlite_flutter_crud/Authtentication/signup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get darkBlue => null;

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage("lib/assets/fondo.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 114,
            right: 114,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Iniciar Sessión2'),
                  onPressed: () {
                    const LoginScreen();
                  },
                ),
                ElevatedButton(
                  child: const Text('Registrarme'),
                  onPressed: () {
                    const SignUp();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );*/

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/fondo.png"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          //We put all our textfield to a form to be controlled and not allow as empty
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //Username field

                //Before we show the image, after we copied the image we need to define the location in pubspec.yaml
                Image.asset(
                  "lib/assets/LOGO.png",
                  width: 210,
                ),
                const SizedBox(height: 300),

                //Login button
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xF0AAF724)),
                  child: TextButton(
                    onPressed: () {
                      //Navigate to sign up
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Iniciar sessión",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 15),

                //Sign up button
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(125, 125, 126, 0.5),
                  ),
                  child: TextButton(
                      onPressed: () {
                        //Navigate to sign up
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text("Registrarme",
                          style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    /*return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/fondo.png"), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Image(image: AssetImage('lib/assets/LOGO.png')),
                  ElevatedButton(
                    child: const Text('Iniciar Sessión2'),
                    onPressed: () {
                      print('login');

                    },
                  )

                  /*buttonWidget("Iniciar Sessión"),
                  buttonWidget("Registrarme")*/
                ]),
          ),
        ),
      ),
    );*/

    /*return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/fondo.png"), fit: BoxFit.cover),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage('lib/assets/LOGO.png')),
          ],
        ),
      ),
    );*/

    /*return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("lib/assets/fondo.png"), fit: BoxFit.cover),
      ),
      child: Center(
        child: FlutterLogo(size: 300),
      ),
    );*/

    /*return const Stack(children: <Widget>[
      Positioned.fill(
        //
        child: Image(
          image: AssetImage('lib/assets/fondo.png'),
          fit: BoxFit.fill,
        ),
      ),

      

    ]);*/

    /*return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/fondo.png"), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              //We put all our textfield to a form to be controlled and not allow as empty
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("lib/assets/fondo2.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: FlutterLogo(size: 300),
                      ),
                    ),

                    //Username field

                    //Before we show the image, after we copied the image we need to define the location in pubspec.yaml
                    Image.asset(
                      "lib/assets/LOGO.png",
                      width: 210,
                    ),
                    const SizedBox(height: 15),

                    //Sign up button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              //Navigate to sign up
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text("Login")),
                        ElevatedButton(
                            onPressed: () {
                              //Navigate to sign up
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Canchas()));
                            },
                            child: const Text("Canchas")),
                        ElevatedButton(
                            onPressed: () {
                              //Navigate to sign up
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Books()));
                            },
                            child: const Text("Reservaciones"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}
