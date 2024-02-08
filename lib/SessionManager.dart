/*class SessionM {
  static String? userId;


  static void setUser(String id){
    userId=id;
  }

  static String? getUserId(){
    return userId;
  }
  
}*/
import 'package:cloud_firestore/cloud_firestore.dart';

class SessionM {
  static String? userId;
  static String? username; // New field to store the username

  static void setUser(String id, String name) {
    userId = id;
    username = name;
  }

  static String? getUserId() {
    return userId;
  }

  static String? getUsername() {
    return username;
  }
}
