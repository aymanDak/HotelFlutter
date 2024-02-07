import 'package:flutter/material.dart';
import 'package:hotelflutter/add_room_widget.dart';
import 'package:hotelflutter/loginA.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord administrateur'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenue, Admin',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de gestion des chambres
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddRoomWidget()));
              },
              child: Text('Gérer les chambres'),
            ),
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton
                // Par exemple, naviguer vers une autre page de gestion
              },
              child: Text('Gérer les réservations'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de connexion lors de la déconnexion
                Navigator.push(context, MaterialPageRoute(builder: (context) => logA()));
              },
              child: Text('Déconnexion'),
            ),
            // Ajoutez d'autres boutons ou éléments selon vos besoins
          ],
        ),
      ),
    );
  }
}