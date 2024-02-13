import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelflutter/database.dart';

class ManageReservationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Gérer les réservations'),
        backgroundColor: Colors.blue, // Couleur de fond de l'appBar
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Database().getReservations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> reservations = snapshot.data ?? [];
            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                return FutureBuilder<DocumentSnapshot>(
                  future: Database().getClient(reservations[index]['userid']),
                  builder: (context, clientSnapshot) {
                    if (clientSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (clientSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${clientSnapshot.error}'));
                    } else {
                      Map<String, dynamic> clientData = {};
                      if (clientSnapshot.data != null && clientSnapshot.data!.data() != null) {
                        clientData = clientSnapshot.data!.data() as Map<String, dynamic>;
                      }
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 4,
                        color: Colors.lightBlue[50], // Couleur de fond de la carte
                        child: ListTile(
                          title: Text('Chambre: ${reservations[index]['label']}',style: TextStyle(fontWeight: FontWeight.w600),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Prix: ${reservations[index]['prix']} Dh', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)), // Couleur du texte en bleu
                              Text('Date de début: ${reservations[index]['dated']}', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
                              Text('Date de fin: ${reservations[index]['datef']}', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.person, color: Colors.blue), // Couleur de l'icône en bleu
                                  SizedBox(width: 8),
                                  Text('${clientData['nom']} ${clientData['prenom']}', style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.email, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text('${clientData['email']}', style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  
}
