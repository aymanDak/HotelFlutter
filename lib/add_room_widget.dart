// add_room_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'editroom.dart ';
import 'package:image_picker/image_picker.dart';
import 'database.dart';

class AddRoomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _AddRoomWidgetContent(),
    );
  }
}

class _AddRoomWidgetContent extends StatefulWidget {
  @override
  _AddRoomWidgetContentState createState() => _AddRoomWidgetContentState();
}

class _AddRoomWidgetContentState extends State<_AddRoomWidgetContent> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController(); // Add controller for description

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> _addRoom() async {
    if (_labelController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _image != null &&
        _descriptionController.text.isNotEmpty) { // Check if description is not empty
      print('Image Path: ${_image?.path}'); // Print image path for debugging
      try {
        // Call the database function to add the room
        await Database.addRoom(
          label: _labelController.text,
          price: double.parse(_priceController.text),
          image: _image!,
          description: _descriptionController.text, // Pass description to addRoom method
        );

        // Reset controllers and image after successful addition
        _labelController.clear();
        _priceController.clear();
        _descriptionController.clear();
        setState(() {
          _image = null; // Reset image to null
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Room added successfully.'),
          ),
        );
      } catch (error) {
        // Show error message if adding room fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add room: $error'),
          ),
        );
      }
    } else {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and select an image.'),
        ),
      );
    }
  }

  Future<void> _showRoom() async {
  try {
    List<Map<String, dynamic>> rooms = await Database.getRooms();
    print('Retrieved rooms: $rooms'); // Print retrieved rooms to console

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rooms'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var room in rooms) ...[
                  if (room.containsKey('image_url') && room.containsKey('label') && room.containsKey('price')) // Check if necessary keys exist and are not null
                    ListTile(
                      leading: room['image_url'] != null ? Image.network(
                        room['image_url'],
                        width: 50,
                        height: 50,
                      ) : SizedBox(), // Use SizedBox if image_url is null
                      title: room['label'] != null ? Text(room['label']) : SizedBox(), // Use SizedBox if label is null
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          room['price'] != null ? Text('\DH${room['price']}') : SizedBox(), // Use SizedBox if price is null
                         // room['description'] != null ? Text(room['description']) : SizedBox(), // Use SizedBox if description is null
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Implement logic to handle update
                              // Pass the room data (room) to the update method
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditRoomPage(label: room['label']),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              try {
                                await Database.deleteRoom(room['label']); // Pass label instead of ID
                                setState(() {
                                  rooms.remove(room);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Room deleted successfully.'),
                                  ),
                                );
                                _showRoom(); // Refresh the dialog
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to delete room: $error'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  Divider(),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  } catch (error) {
    // Show error message if fetching rooms fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to fetch rooms: $error'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Room'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/hotel-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: _pickImage,
                child: _image != null
                    ? Image.file(
                        _image!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey[200],
                        child: Icon(Icons.add_a_photo),
                      ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _labelController,
                decoration: InputDecoration(labelText: 'Label'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _addRoom,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      primary: Colors.blue,
                    ),
                    child: Text(
                      'Add Room',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showRoom,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      primary: Colors.green,
                    ),
                    child: Text(
                      'Show Rooms',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}