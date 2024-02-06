import 'package:cloud_firestore/cloud_firestore.dart';


class Database{
  Future ajouter_Etudiant(Map<String,dynamic> infosEtudiants,String id)async{
    return await FirebaseFirestore.instance.collection("Student").doc(id).set(infosEtudiants);
  }
  
}