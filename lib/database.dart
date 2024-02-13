import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelflutter/SessionManager.dart';

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
  required String description, // New parameter for description
}) async {
  try {
    // Check if a room with the same label already exists
    QuerySnapshot querySnapshot = await _firestore.collection('rooms')
        .where('label', isEqualTo: label)
        .get();
    
    if (querySnapshot.docs.isNotEmpty) {
      throw ('Room with label "$label" already exists.');
    }

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
      'description': description, // Include description in Firestore document
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

  /*static Future<void> updateRoom(String roomId, {
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
  }*/
static Future<void> updateRoom(String label, Map<String, dynamic> updatedData, File? image) async {
  try {
    Map<String, dynamic> updatedRoom = {};

    if (updatedData.containsKey('label')) updatedRoom['label'] = updatedData['label'];
    if (updatedData.containsKey('price')) updatedRoom['price'] = updatedData['price'];
    if (updatedData.containsKey('description')) updatedRoom['description'] = updatedData['description']; // Add description to updated room data

    if (image != null) {
      String imagePath = 'rooms/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _storage.ref().child(imagePath).putFile(image);
      String imageUrl = await _storage.ref(imagePath).getDownloadURL();
      updatedRoom['image_url'] = imageUrl;
    }

    QuerySnapshot querySnapshot = await _firestore.collection('rooms').where('label', isEqualTo: label).get();
    querySnapshot.docs.forEach((doc) async {
      await _firestore.collection('rooms').doc(doc.id).update(updatedRoom);
    });
  } catch (error) {
    throw ('Error updating room: $error');
  }
}



 /* static Future<void> deleteRoom(String roomId) async {
    try {
      await _firestore.collection('rooms').doc(roomId).delete();
    } catch (error) {
      throw ('Error deleting room: $error');
    }
  }*/
  static Future<void> deleteRoom(String label) async {
  try {
    QuerySnapshot querySnapshot = await _firestore.collection('rooms').where('label', isEqualTo: label).get();
    querySnapshot.docs.forEach((doc) async {
      await _firestore.collection('rooms').doc(doc.id).delete();
    });
  } catch (error) {
    throw ('Error deleting room: $error');
  }
}
Future<bool> verifierInformationsConnexion(String email, String motDePasse) async {
  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Client')
        .where('email', isEqualTo: email)
        .where('pass', isEqualTo: motDePasse)
        .get();

    /*if (querySnapshot.docs.isNotEmpty) {
      // Authentification réussie, définir l'ID de l'utilisateur dans la session
      SessionM.setUser(querySnapshot.docs.first.id);
      return true;
    } */
    if (querySnapshot.docs.isNotEmpty) {
  // Authentication successful, set the user ID and username in the session
  String userId = querySnapshot.docs.first.id;
  String username = querySnapshot.docs.first['username']; // Adjust 'username' to the actual field name in your Firestore document
  SessionM.setUser(userId, username);
  return true;
}

    
    else {
      return false;
    }
  } catch (e) {
    print('Erreur lors de la vérification des informations de connexion: $e');
    throw e; // Gérer l'erreur selon les besoins
  }
}

static Future<Map<String, dynamic>> getRoomByLabel(String label) async {
  try {
    var query = await _firestore.collection('rooms').where('label', isEqualTo: label).get();
    if (query.docs.isNotEmpty) {
      Map<String, dynamic> roomData = query.docs.first.data() as Map<String, dynamic>;
      roomData['id'] = query.docs.first.id;
      return roomData;
    } else {
      throw Exception('Room not found with label $label');
    }
  } catch (error) {
    throw ('Error getting room details: $error');
  }
}

Future<bool> ajouterReservation(Map<String, dynamic> infosReservation) async {
  try {
    var docRef = FirebaseFirestore.instance.collection("reservations").doc(); // Firestore générera un ID automatique
    await docRef.set(infosReservation);
    return true; // Indique que l'ajout s'est terminé avec succès
  } catch (e) {
    print("Erreur lors de l'ajout de la réservation: $e");
    return false; // Indique que l'ajout a échoué
  }
}
static Future<List<Map<String, dynamic>>> getReservationsByUserId(String userId) async {
  try {
    // Query Firestore to get reservations for the specified userId
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('reservations')
        .where('userid', isEqualTo: userId)
        .get();

    // Convert the query snapshot to a list of maps
    List<Map<String, dynamic>> reservations = querySnapshot.docs.map((doc) => doc.data()).toList();
    
    return reservations;
  } catch (error) {
    // Handle errors, such as Firestore query failures
    print('Error fetching reservations: $error');
    throw 'Failed to fetch reservations: $error';
  }
}


Future<List<Map<String, dynamic>>> getReservations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('reservations').get();

      List<Map<String, dynamic>> reservations =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      return reservations;
    } catch (error) {
      print('Error fetching reservations: $error');
      throw 'Failed to fetch reservations: $error';
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getClient(String clientId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('Client')
          .doc(clientId)
          .get();
    } catch (error) {
      print('Error fetching client: $error');
      throw 'Failed to fetch client: $error';
    }
  }


}
