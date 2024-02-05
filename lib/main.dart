import 'package:flutter/material.dart';
import 'add_room_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/add_room': (context) => AddRoomScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Home Screen Content',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                    Navigator.pushNamed(context, '/add_room');

              },
              child: Text('Go to Add Room Screen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add more actions here or navigate to other pages
              },
              child: Text('Other Action'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddRoomWidget(),
      ),
    );
  }
}
