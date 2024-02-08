import 'package:flutter/material.dart';
import 'package:hotelflutter/SessionManager.dart';
import 'package:hotelflutter/loginA.dart';
import 'package:hotelflutter/loginC.dart';
import 'package:hotelflutter/reservationDetails.dart';
import 'package:hotelflutter/reservation_details_screen.dart';
import 'database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> roomsFuture;

  @override
  void initState() {
    super.initState();
    roomsFuture = Database.getRooms(); // Fetch rooms from Firestore
  }

  @override
  Widget build(BuildContext context) {
    String? userid = SessionM.getUserId();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: roomsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final rooms = snapshot.data!;
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Reservation(
                              imageUrl: room['image_url'],
                              label: room['label'],
                              price: room['price'],
                              description:room['description']
                            ),
                          ),
                        );
                       
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                            image: NetworkImage(room['image_url'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  room['label'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  room['price'].toString() + " Dh/nuits",
                                  style: TextStyle(
                                    color: Colors.blue.shade200,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Espacement entre les images
                  ],
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle home button tap
              },
            ),
           SessionM.getUserId() != null
  ? IconButton(
      icon: Icon(Icons.calendar_today), // Changed icon to reservations icon
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReservationDetailsScreen(userId: SessionM.getUserId()!),
          ),
        );
      },
    )
  : SizedBox(), // If the user is not logged in, show an empty SizedBox

            
            IconButton(
  icon: Icon(Icons.account_circle),
  onPressed: () async {
    // Handle profile button tap
    // Check authentication state

    String? username = SessionM.getUsername();
    if (username != null) {
      // User is logged in, show logout dialog with username
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Logged in as: $username'),
                Text('Are you sure you want to logout?'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context); // Close the dialog
                  // Perform logout actions
                        Navigator.push(context, MaterialPageRoute(builder: (context) => loginC()));


                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('No'),
              ),
            ],
          );
        },
      );
    } else {
      // User is not logged in, navigate to login screen
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginC()));
    }
  },
),

          ],
        ),
      ),
    );
  }
  /*title: Text(room['label'] ?? ''),
                  subtitle: Text('Price: ${room['price']}'),
                  leading: Image.network(room['image_url'] ?? ''), // Display room image
                  // Add Reserve button
                  trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Reservation(
                              imageUrl: room['image_url'],
                              label: room['label'],
                              price: room['price'],
                            ),
                          ),
                        );
                      },
                      child: Text('Reserve'),
                    ), */
}
