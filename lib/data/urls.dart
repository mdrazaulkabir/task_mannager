class Urls{
  static const String baseUrl="http://35.73.30.144:2005/api/v1";
  static const String registrationUrl="$baseUrl/Registration";
  static const String loginUrl="$baseUrl/Login";
  static const String createNewTaskUrl="$baseUrl/createTask";
  static const String getNewTaskListUrl="$baseUrl/listTaskByStatus/New";
  static const String getProgressTaskListUrl="$baseUrl/listTaskByStatus/Progress";
  static const String getCancelTaskListUrl="$baseUrl/listTaskByStatus/Canceled";
  static const String getCompleteTaskListUrl="$baseUrl/listTaskByStatus/Complete";
  static const String getTaskStatusCountListUrl="$baseUrl/taskStatusCount";
  static String updateTaskStatusUrl(String taskId, String status)=>"$baseUrl/updateTaskStatus/$taskId/$status";
  static const String updateProfileUrl="$baseUrl/ProfileUpdate";

  static  String emailUrl(String email)=>"$baseUrl/RecoverVerifyEmail/$email";
  static String otpUrl(String email, String otp)=>"$baseUrl/RecoverVerifyOtp/$email/$otp";
  static const String resetUrl="$baseUrl/RecoverResetPassword";
  static String deleteUrl(String id)=>"$baseUrl/deleteTask/$id";

}