class Todo{
  int? id;
  String? todo;
  String? description;
  bool? isComplete;

  Todo.fromJson(Map json):
      id=json['id'],
      todo=json['todo'],
      description=json['description'],
      isComplete=json['isComplete'];

  Map toJson()=>{
    "id":id,
    "todo":todo,
    "description":description,
    "isComplete":isComplete
  };

}