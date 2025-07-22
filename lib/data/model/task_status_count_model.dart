class TaskStatusCountModel{
  late String id;
  late int count;
  TaskStatusCountModel.formJson(Map<String, dynamic>jsonData){
    id=jsonData["_id"];
    count=jsonData["sum"];
  }
}