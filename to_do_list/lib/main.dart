import 'package:flutter/material.dart';
import 'package:to_do_list/task.dart';
import 'package:to_do_list/task_info.dart';

typedef IntCallback(int id);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  bool showAddTaskTextField = false;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final taskList = task_info.taskList();
  int idCounter = 5;
  List<task_info> foundTask = [];

  @override
  void initState() {
    foundTask = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    createTaskInfo(String name) { //helper method that creates a task
      int newId = idCounter;
      idCounter++;
      return task_info(id: idCounter, taskName: name,);
    }

    delete(int? id) {
      for (task_info infoFound in taskList) {
        if (infoFound.id == id) {
          setState(() {
            taskList.remove(infoFound);
            return;
          });
        }
      }
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 29, 29),
        appBar: AppBar(
          title: const Text(
            'To-Do List',
            style: TextStyle(color: Colors.black,)
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, .7),
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.purple.shade100, const Color.fromARGB(255, 26, 29, 29)],
              )
            )
          ),
        ),
    
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:20, bottom:10),
                          child: Text(
                            'Current Tasks', 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),   
                          )
                        ),
                        for (task_info infoFound in foundTask)
                        Task(
                          info: infoFound,
                          myCallback2: (int? id) {
                            delete(id);
                          },
                        ),
                      ]
                    ),
                  )
                ]
              )
            ),
            widget.showAddTaskTextField ? Stack(// add task popup
              alignment: Alignment.center, 
              children: [
                Container( //the black screen outside of the create task box
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(127, 0, 0, 0),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.showAddTaskTextField = false;
                      });
                    },
                    
                  ),
                  
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible( //Create Task Box
                      child: FractionallySizedBox(
                        widthFactor:0.6,
                        alignment: Alignment(1, 0),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding:EdgeInsets.symmetric(horizontal:15),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 15,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                maxHeight: 20,
                                maxWidth: 20
                              ),
                              border: InputBorder.none,
                              hintText: 'Task Name Here',
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                            onSubmitted: (taskName) {
                              setState(() {
                                taskList.add(createTaskInfo(taskName));
                                widget.showAddTaskTextField = false;
                              });
                            },
                          )
                        ),
                      ),
                    ),
                    // TODO: this is a button the user will press to create the task!!!!!
                  ],
                ),
              ],
            ) : Container(),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              if (widget.showAddTaskTextField == true) {widget.showAddTaskTextField = false;}
              else {widget.showAddTaskTextField = true;}
            });
          },
        ),

      ),
    );
  }

  void runFilter(String prompt) {
    List<task_info> results = [];
    if (prompt.isEmpty) {results = taskList;}
    else {
      results = taskList.where((specificTask) => specificTask.taskName!.toLowerCase().contains(prompt.toLowerCase())).toList();
    }
    setState(() {
      foundTask = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding:EdgeInsets.symmetric(horizontal:15),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 15,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 20
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        onChanged: (value) {
          runFilter(value);
        },
      )
    );
  }
}


