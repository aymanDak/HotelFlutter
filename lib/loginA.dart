import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotelflutter/accueil.dart';
import 'package:hotelflutter/inscrire.dart';

class logA extends StatefulWidget {
  const logA({super.key});

  @override
  State<logA> createState() => _logAState();
}

class _logAState extends State<logA> {
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
                
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> acc()));
                
              },
              child: const Text("connexion",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w500
                
              ),),
            ),
          ),
          const SizedBox(height: 40,),
           Text.rich(
            TextSpan(
              text: 'vous n avez pas un compte?',
              style: TextStyle(
                color: Color(0xFF0069FE),
                fontSize: 16

              ),
              
              children: <TextSpan>[
                
                TextSpan(
                  text: 'Cliquez ici',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,                  
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> inscrire()));
                    },
                  
                )
              ]
              
              )
            
              
          )


        ],
        
      ),
      );
  }
}