import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database.dart';

class EditRoomPage extends StatefulWidget {
  final String label;

  EditRoomPage({required this.label});

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  late TextEditingController _labelController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController; // Add controller for description
  File? _image;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController(); // Initialize description controller

    // Fetch room details using label when the widget initializes
    _fetchRoomDetails();
  }
Future<void> _fetchRoomDetails() async {
  try {
    Map<String, dynamic> room = await Database.getRoomByLabel(widget.label);
    setState(() {
      _labelController.text = room['label'];
      _priceController.text = room['price'].toString();
      _descriptionController.text = room['description'] ?? '';
      // Set the image if available
      if (room['image_url'] != null) {
        _image = room['image_url']; // Just assign the URL directly
      }
    });
  } catch (error) {
    // Handle error fetching room details
  }
}


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Room'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
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
              decoration: InputDecoration(labelText: 'Description'), // Add description text field
            ),
            SizedBox(height: 16),
           ElevatedButton(
  onPressed: () async {
    // Prepare updated data
    Map<String, dynamic> updatedData = {
      'label': _labelController.text,
      'price': double.parse(_priceController.text),
      'description': _descriptionController.text, // Add description to updated data
    };

    // Update the room
    await Database.updateRoom(widget.label, updatedData, _image);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Room updated successfully.'),
      ),
    );

    // Navigate back to the previous screen
    Navigator.pop(context);
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Adjust padding as needed
    primary: Colors.green, // Change button color
  ),
  child: Text(
    'Save Changes',
    style: TextStyle(fontSize: 16, color: Colors.white), // Set text color to white
  ),
),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _labelController.dispose();
    _priceController.dispose();
    _descriptionController.dispose(); // Dispose description controller
    super.dispose();
  }
}
