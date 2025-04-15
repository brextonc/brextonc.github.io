import 'package:flutter/material.dart';
import 'package:to_do_list/task_info.dart';

typedef void VoidCallback();
typedef void IntCallback(int? arg);

class Task extends StatefulWidget {
  final IntCallback myCallback2;
  final task_info info;
  const Task({
    super.key, 
    required this.info,
    required this.myCallback2,
    });

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  
  @override
  Widget build(BuildContext context) {

    deleteTask() {
      widget.myCallback2(widget.info.id);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          setState(() {
              if (widget.info.isDone == true) {widget.info.isDone = false;}
              else {widget.info.isDone = true;}
            });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: const Color.fromARGB(255, 85, 110, 122),
        leading: IconButton(
          onPressed: () {
            setState(() {
              if (widget.info.isDone == true) {widget.info.isDone = false;}
              else {widget.info.isDone = true;}
            });
          },
          icon: Icon(
            widget.info.isDone? Icons.check_box : Icons.check_box_outline_blank,
          ),
          color: Colors.lightBlueAccent, 
        ),
        title: Text(
          widget.info.taskName!,
          style: TextStyle(
            fontSize: 15,
            color:widget.info.isDone?Colors.grey : Colors.white70,
            decoration: widget.info.isDone? TextDecoration.lineThrough : null,
          )
        ),
        trailing: DeleteWidget(
          myCallback: () {
            deleteTask();
          }
        ),
      )
    );
  }
}


class DeleteWidget extends StatefulWidget {
  //final int id;
  final VoidCallback myCallback;
  
  const DeleteWidget({
    required this.myCallback,
    });
  _DeleteWidgetState createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
  bool isHover=false;
  
  @override
   Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(vertical:10),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: (isHover) ?  Colors.red: const Color.fromARGB(255, 85, 110, 122),
          borderRadius: BorderRadius.circular(5),
        ),
      duration: Duration(milliseconds: 200),
      child: 
          IconButton(
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
            color: (isHover) ? Colors.white: Colors.red,
            iconSize: 25,
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.myCallback();
            },
            onHover: (val) {
            setState(() {
              isHover = val;
            });
          },
          )
    );
  }
}