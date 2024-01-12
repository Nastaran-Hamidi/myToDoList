import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/widgets/boxes.dart';

class MyHomePage extends StatefulWidget {
  final String? title;
  const MyHomePage({super.key, this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final todoList=ToDo.todoList();
  final tabController=TextEditingController();
  List<ToDo> _founds=[];

  @override
  void initState() {
    _founds=todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              SearchBox(),
              Expanded(
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0,top: 15.0, bottom: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("All ToDoes",
                              style: TextStyle(color: Colors.black,fontSize: 25)
                          ),
                        ),
                      ),
                      for (ToDo todoo in _founds)
                        ToDoBoxes(
                          todo: todoo,
                          onChanged: _handleToDoChange,
                          onDeleteItem: deleteItem,
                        ),
                    ],
                 )
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40,right: 20,left: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      height: 60,
                      width: 80,
                      margin: const EdgeInsets.only(right:10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: tabController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add New Item ..."
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: indianRed,
                          elevation: 10
                      ),
                      onPressed: () =>addToList(tabController.text),
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void deleteItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id==id);
    });
  }

  void addToList(String todo){
    setState(() {
      todoList.add(
          ToDo(id: DateTime.now().millisecond.toString(), name: todo)
      );
    });
    tabController.clear();
  }

  void filter(String searchWord){
    List<ToDo> results=[];
    if(searchWord.isEmpty){
      results=todoList;
    }
    else{
      results=todoList.where((item) =>
          item.name!.toLowerCase().contains(searchWord.toLowerCase())).toList();
    }
    setState(() {
      _founds=results;
    });
  }

  Widget SearchBox(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: TextField(
        onChanged: (value)=>filter(value),
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search,color: Colors.grey),
            hintText: "Search"
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: lightBlue,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        const Icon(Icons.menu),
        SizedBox(
          height: 40,
           width: 40,
           child: ClipRRect(
             borderRadius: BorderRadius.circular(50),
             child: Image.asset('assets/profile.jpg')
           )
        )
      ]),
    );
  }
}