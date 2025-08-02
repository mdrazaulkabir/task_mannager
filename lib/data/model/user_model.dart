class UserModel{
  late String id;
  late String email;
  late String lastName;
  late String firstName;
  late String mobile;
  String? photo;

  String get fullName{
    return '$firstName $lastName';
  }
  UserModel.formJson(Map<String,dynamic>jsonData){
    id= jsonData['_id'];
    email= jsonData['email'];
    lastName= jsonData['lastName'];
    firstName= jsonData['firstName'];
    mobile= jsonData['mobile'];
    photo=jsonData['photo'];
  }

  Map<String,dynamic>toJson(){
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      "photo":photo,
    };
  }
}