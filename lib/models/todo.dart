class ToDo{
  String? id;
  String? name;
  bool checked;

  ToDo({
    required this.id,
    required this.name,
    this.checked=false
  });

  static List<ToDo> todoList(){
    return [
      ToDo(id: "1", name: "checking email", checked: true),
      ToDo(id: "2", name: "calling boss"),
      ToDo(id: "3", name: "shopping", checked: true),
      ToDo(id: "4", name: "painting"),
      ToDo(id: "5", name: "eating dinner"),
      ToDo(id: "6", name: "meeting with friends")
    ];
  }
}