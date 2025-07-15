class UserModel{
  late String id;
  late String email;
  late String lastName;
  late String firstName;
  late String mobile;
  UserModel.formJson(Map<String,dynamic>jsonData){
    id= jsonData['_id'];
    email= jsonData['email'];
    lastName= jsonData['firstName'];
    firstName= jsonData['lastName'];
    mobile= jsonData['mobile'];
  }

  Map<String,dynamic>toJson(){
    return{
    '_id':id,
    'email':email,
      'firstName':firstName,
      'lastName':lastName,
      'mobile':mobile
    };
  }

}