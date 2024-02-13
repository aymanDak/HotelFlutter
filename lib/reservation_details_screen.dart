import 'package:flutter/material.dart';
import 'package:hotelflutter/database.dart'; // Import the database helper

class ReservationDetailsScreen extends StatefulWidget {
  final String userId;

  const ReservationDetailsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ReservationDetailsScreenState createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  late Future<List<Map<String, dynamic>>> reservationFuture;

  @override
  void initState() {
    super.initState();
    reservationFuture = Database.getReservationsByUserId(widget.userId); // Fetch reservations by userId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: reservationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final reservations = snapshot.data!;
            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                // Build UI for each reservation item
                return Column(
                  children: [
                    ListTile(
                      title: Text('Reservation ${index + 1}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue.shade500)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Room: ${reservation['label']}'),
                          Text('Check-in: ${reservation['dated']}'),
                          Text('Check-out: ${reservation['datef']}'),
                          Text('Price: ${reservation['prix']} MAD'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30, // Couleur rouge pour l'icône
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Êtes-vous sûr de vouloir supprimer cette réservation ?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        await Database.deleteReservation(reservation['id']);
                                        Navigator.of(context).pop(); // Ferme la boîte de dialogue de confirmation
                                        setState(() {
                                          // Rafraîchit l'interface pour refléter la suppression de la réservation
                                          reservations.removeAt(index);
                                        });
                                      } catch (error) {
                                        print('Error deleting reservation: $error');
                                        // Gérer les erreurs de suppression de réservation
                                      }
                                    },
                                    child: Text('Oui'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Ferme la boîte de dialogue de confirmation
                                    },
                                    child: Text('Non'),
                                  ),
                                ],
                              );
                            },
                          );
                        
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Divider(
                        height: 4,
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
