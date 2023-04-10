class Todo{
  int? id;
  String? title;
  String? description;
  bool? isCompleted;

  Todo.fromJson(Map json):
      id=json['id'],
      title=json['title'],
      description=json['description'],
      isCompleted=json['completed'];

  Map toJson()=>{
    "id":id,
    "title":title,
    "description":description,
    "isComplete":isCompleted
  };

}