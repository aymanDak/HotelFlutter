import 'package:flutter/material.dart';
import 'package:hotelflutter/loginA.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Rafelz'),
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
                return ListTile(
                  title: Text(room['label'] ?? ''),
                  subtitle: Text('Price: ${room['price']}'),
                  leading: Image.network(room['image_url'] ?? ''), // Display room image
                  // You can add more information or customize the ListTile as needed
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
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search button tap
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notifications button tap
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: ()async {
                // Handle profile button tap
                // Check authentication state
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, show logout dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context); // Close the dialog
                        Navigator.push(context, MaterialPageRoute(builder: (context) => logA()));

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => logA()));
    }
              },
            ),
          ],
        ),
      ),
    );
  }
}
