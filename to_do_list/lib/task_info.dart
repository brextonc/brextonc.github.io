import 'package:to_do_list/task.dart';

class task_info {
  int? id;
  String? taskName;
  bool isDone;
  

  task_info ({
    required this.id,
    required this.taskName,
    this.isDone = false,
  });

  static List<task_info> taskList () {
    return [
      task_info(id: 0, taskName: 'start project', isDone: true),
      task_info(id: 1, taskName: 'write rough draft', isDone: true),
      task_info(id: 2, taskName: 'present project', ),
      task_info(id: 3, taskName: 'write final draft', ),
      task_info(id: 4, taskName: 'drop out of school', ),      
    ];
  }
}