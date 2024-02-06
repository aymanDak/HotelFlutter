import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

    Future ajouter_Client(Map<String, dynamic> infosClient) async {
  var docRef = FirebaseFirestore.instance.collection("Client").doc(); // Firestore générera un ID automatique
  return await docRef.set(infosClient);
}
  

  static Future<void> addRoom({
  required String label,
  required double price,
  required File image,
}) async {
  try {
    // Upload image to Firebase Storage
    String imagePath = 'rooms/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await _storage.ref().child(imagePath).putFile(image);

    // Get download URL of the uploaded image
    String imageUrl = await _storage.ref(imagePath).getDownloadURL();

    // Add room data to Firestore
    await _firestore.collection('rooms').add({
      'label': label,
      'price': price,
      'image_url': imageUrl,
      'created_at': FieldValue.serverTimestamp(),
    });
  } catch (error) {
    throw ('Error adding room: $error');
  }
}


  static Future<List<Map<String, dynamic>>> getRooms() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('rooms').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (error) {
      throw ('Error getting rooms: $error');
    }
  }

  static Future<void> updateRoom(String roomId, {
    String? label,
    double? price,
    File? image,
  }) async {
    try {
      Map<String, dynamic> updatedData = {};

      if (label != null) updatedData['label'] = label;
      if (price != null) updatedData['price'] = price;

      if (image != null) {
        String imagePath = 'rooms/${DateTime.now().millisecondsSinceEpoch}.jpg';
        await _storage.ref().child(imagePath).putFile(image);
        String imageUrl = await _storage.ref(imagePath).getDownloadURL();
        updatedData['image_url'] = imageUrl;
      }

      await _firestore.collection('rooms').doc(roomId).update(updatedData);
    } catch (error) {
      throw ('Error updating room: $error');
    }
  }

  static Future<void> deleteRoom(String roomId) async {
    try {
      await _firestore.collection('rooms').doc(roomId).delete();
    } catch (error) {
      throw ('Error deleting room: $error');
    }
  }
}
