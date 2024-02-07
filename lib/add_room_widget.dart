// add_room_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
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
      _image != null) {
    print('Image Path: ${_image?.path}'); // Print image path for debugging
    try {
      // Call the database function to add the room
      await Database.addRoom(
        label: _labelController.text,
        price: double.parse(_priceController.text),
        image: _image!,
      );

      // Reset controllers and image after successful addition
      _labelController.clear();
      _priceController.clear();
     /* setState(() {
        _image = File(''); // Reset image to empty file
      });*/
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
                  ListTile(
                    leading: Image.network(
                      room['image_url'], // Assuming the image_url key holds the URL of the image
                      width: 50,
                      height: 50,
                    ),
                    title: Text(room['label']),
                    subtitle: Text('\$${room['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Implement logic to handle update
                            // Pass the room data (room) to the update method
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
           _showRoom(); //refresh the dialog

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
      body: SingleChildScrollView(
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
            ElevatedButton(
              onPressed: _addRoom,
              child: Text('Add Room'),
            ),
             SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showRoom,
              child: Text('Show Rooms'),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
