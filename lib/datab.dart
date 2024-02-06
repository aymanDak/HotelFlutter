import 'package:cloud_firestore/cloud_firestore.dart';


class Datab{
  Future ajouter_Client(Map<String, dynamic> infosClient) async {
  var docRef = FirebaseFirestore.instance.collection("Client").doc(); // Firestore générera un ID automatique
  return await docRef.set(infosClient);
}
  
}