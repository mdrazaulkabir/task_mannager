class VerificationDataModel{

  // "status": "success",
  // "data": "A 6 digit OTP code sent to your email"

  late String status;
  late String data;
  VerificationDataModel.fromJson(Map<String,dynamic>jsonData){
    status=jsonData['status'];
    data=jsonData['data'];
  }
}