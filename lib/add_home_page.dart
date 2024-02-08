import 'package:flutter/material.dart';
import 'package:hotelflutter/add_room_widget.dart';
import 'package:hotelflutter/loginA.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool _textVisible = false;

  @override
  void initState() {
    super.initState();
    // Définir un délai pour afficher le texte progressivement
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _textVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord administrateur'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0), // Ajout d'un espace en haut de la page
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AnimatedOpacity(
                  opacity: _textVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: TypewriterAnimatedTextKit(
                    isRepeatingAnimation: false,
                    speed: Duration(milliseconds: 100),
                    text: ['Bienvenue sur le tableau de bord administrateur. Vous pouvez gérer les chambres et les réservations ici.'],
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SizedBox(height: 130.0),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de gestion des chambres
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddRoomWidget()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                textStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              child: Text('Gérer les chambres'),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 16.0),
                textStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              child: Text('Gérer les réservations'),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            // Naviguer vers la page de connexion lors de la déconnexion
            Navigator.push(context, MaterialPageRoute(builder: (context) => logA()));
          },
          child: Icon(Icons.logout, color: Colors.black), // Icon en noir
          backgroundColor: Colors.white, // Couleur de fond blanche pour le contraste
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}