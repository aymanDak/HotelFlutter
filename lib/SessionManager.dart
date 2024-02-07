class SessionM {
  static String? userId;


  static void setUser(String id){
    userId=id;
  }

  static String? getUserId(){
    return userId;
  }
  
}