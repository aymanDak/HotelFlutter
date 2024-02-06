// ignore_for_file: unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:hotelflutter/accueil.dart';
import 'package:hotelflutter/inscrire.dart';
import 'package:hotelflutter/loginA.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}):super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: _initializeFirebase(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          return const LoginScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },),
      );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}):super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand( // Ajouter SizedBox.expand ici
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade300,
                Colors.blue.shade100
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80,),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children:<Widget> [
                      Text("Authentification",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Bienvenue chez rafelz",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(89, 123, 235, 0.634),
                                  blurRadius: 20,
                                  offset: Offset(0,10)
                              )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "address email...",
                                      hintStyle: TextStyle(color: Colors.blueGrey),
                                      prefixIcon: Icon(Icons.mail,color: Colors.blue.shade100,),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock, color: Colors.blue.shade100,),
                                      hintText: "Mot de passe...",
                                      hintStyle: TextStyle(color: Colors.blueGrey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue.shade900,
                          ),
                          child: Center(
                            child: Text("Connexion",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: (){
                             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> inscrire()));
                          },
                          child :Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue.shade800,
                            ),
                            child: Center(
                              child: Text("Inscrire",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("Pour l'admin",style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 30,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child :GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> logA()));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue.shade500,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Acce Admin",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
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
