import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRoomWidget extends StatefulWidget {
  @override
  _AddRoomWidgetState createState() => _AddRoomWidgetState();
}

class _AddRoomWidgetState extends State<AddRoomWidget> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  late File _image = File(''); // Initialize with an empty File

Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
      // You might want to handle this case, e.g., show a default image
    }
  });
}


  Future<void> _addRoom() async {
    if (_labelController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _image != null) {
      // Perform your room addition logic here
      print('Label: ${_labelController.text}');
      print('Price: ${_priceController.text}');
      print('Image path: ${_image.path}');

      // You can continue with your logic to upload image and add room to Firebase
    } else {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and select an image.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: _pickImage,
          child: _image != null
              ? Image.file(
                  _image,
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
      ],
    );
  }
}
