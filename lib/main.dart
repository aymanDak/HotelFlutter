// ignore_for_file: unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotelflutter/accueil.dart';
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
static Future<User?> login({required String email,required password,required BuildContext context}) async{
  FirebaseAuth auth=FirebaseAuth.instance;
  User? user;
  try{
    UserCredential userCredential =await auth.signInWithEmailAndPassword(email: email, password: password);
    user =userCredential.user;

  }on FirebaseAuthException catch(e){
    if(e.code=="user-not-found"){
      print("no User found for that email");
    }
  }
  return user;
  
}


  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontr=TextEditingController();
    TextEditingController passcontr=TextEditingController();
    return  Padding(
      padding:const  EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Text("Authentification",style: TextStyle(
            color: Color(0xFF0069FE),
            fontSize: 28.0,
            fontWeight: FontWeight.w900,
          
          ),),
           const SizedBox(height: 44.0,),
           TextField(
            controller: emailcontr,
            keyboardType: TextInputType.emailAddress,
            decoration:const InputDecoration(
            hintText: "Address email...",
            prefixIcon: Icon(Icons.mail,color: Colors.black,)
          ) ,
          ),
           const SizedBox(height: 26,),
            TextField(
              controller: passcontr,
              obscureText: true,
              decoration: InputDecoration(
              hintText: "Mot de passe...",
              prefixIcon: Icon(Icons.lock, color: Colors.black,)
            ),
          ),
           const SizedBox(
            height: 18
            ),
           const Text("Mot de passe oublier?",
            style: TextStyle(color: Colors.blue),textAlign: TextAlign.start,),
           const SizedBox(height: 88,),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: const Color(0xFF0069FE),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              onPressed: () async{
                User? user =await login(email: emailcontr.text, password: passcontr.text, context: context);
                print(user);
                if(user != null){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> acc()));
                }
              },
              child: const Text("connexion",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w500
                
              ),),
            ),
          ),

        ],
        
      ),
      );
  }
}
