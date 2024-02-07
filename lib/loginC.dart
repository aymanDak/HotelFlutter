import 'package:flutter/material.dart';
import 'package:hotelflutter/database.dart';
import 'package:hotelflutter/home_screen.dart';
import 'package:hotelflutter/inscrire.dart';
import 'package:hotelflutter/loginA.dart';

class loginC extends StatefulWidget {
  const loginC({super.key});

  @override
  State<loginC> createState() => _loginCState();
}

class _loginCState extends State<loginC> {
  TextEditingController emeil=TextEditingController();
TextEditingController pass=TextEditingController();
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
                      Text("Bienvenue chez Raffles",
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
                                  controller: emeil,
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
                                  controller: pass,
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
                        GestureDetector(
                          onTap: () async{
                            
                            bool utilisateurExiste = await Database().verifierInformationsConnexion(emeil.text, pass.text);
                            if (utilisateurExiste) {
                              // Authentification réussie, rediriger vers la page d'accueil
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            } else {
                              // Afficher un message d'erreur à l'utilisateur
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Email ou mot de passe incorrect.'),
                                ),
                              );
                            }
                          },
                        child:Container(
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
                        ),),
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