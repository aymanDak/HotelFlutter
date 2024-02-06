import 'package:flutter/material.dart';
import 'package:hotelflutter/loginA.dart';
import 'package:hotelflutter/main.dart';
import 'database.dart';

class inscrire extends StatefulWidget {
  const inscrire({super.key});

  @override
  State<inscrire> createState() => _inscrireState();
}

class _inscrireState extends State<inscrire> {
  TextEditingController prenom=TextEditingController();
  TextEditingController nom=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController tele=TextEditingController();
  TextEditingController pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> logA()));
        },
        ),),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(24) ,
          child: Column(
            children: [
              Text("Creations de du compte",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue
              )),
              const SizedBox(height: 32,),

              Form(
                child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          expands: false,
                          controller: prenom,
                          
                          decoration:  InputDecoration(
                            labelText: "prenom",
                            prefixIcon: Icon(Icons.man),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              
                            )
                            ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: TextFormField(
                          controller: nom,
                          expands: false,
                          decoration:  InputDecoration(
                            labelText: "nom",
                            prefixIcon: Icon(Icons.man),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                            
                            ),
                        ),
                      ),
                     
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: username,
                    expands: false,
                    decoration:  InputDecoration(
                      labelText: "nom d'utilisateur...",
                      prefixIcon: Icon(Icons.man_2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                      ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: email,
                    expands: false,
                    decoration:  InputDecoration(
                      labelText: "address email...",
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                      ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: tele,
                    expands: false,
                    decoration:  InputDecoration(
                      labelText: "telephone...",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                      ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: pass,
                    expands: false,
                    decoration:  InputDecoration(
                      labelText: "mot de passe...",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                      ),
                  ),
                  SizedBox(height: 50,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async{
                        Map<String,dynamic> infos={
                      "prenom":prenom.text,
                      "nom":nom.text,
                      "username":username.text,
                      "email":email.text,
                      "tele":tele.text,
                      "pass":pass.text,
                    };
                    await Database().ajouter_Client(infos);

                      },
                      child: const Text("Enregistrer",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue.shade400),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Définir le rayon du bord
                          ),
                        ),
                        
                      ),
                    ),
                    
                    )
                  
                ],
              ))

            ],
          
        ),
        ),
      ),
    );
  }
}