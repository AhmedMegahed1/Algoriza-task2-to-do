import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/core/util/cubit/todo_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late Database database;
  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favoritTasks = [];
  TextEditingController? titlecontroller = TextEditingController();
  // validatedate() {
  //   if (titlecontroller.text.isEmpty) {
  //     Get.snackbar('required', 'All field are required',
  //         duration: const Duration(seconds: 3),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.amberAccent,
  //         colorText: Colors.pink,
  //         icon: const Icon(
  //           Icons.warning_amber_rounded,
  //           color: Colors.red,
  //         ));
  //   } else {
  //     print('object');
  //   }
  // }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT,endTime TEXT ,remind TEXT,repeat TEXT,color INTEGER,status TEXT,favorite TEXT)')
            .then((value) {
          debugPrint('table created');
        }).catchError((error) {
          debugPrint('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        debugPrint('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required int remind,
    required String repeat,
    required int color,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title,date,startTime,endTime,remind,repeat,color,status,favorite) VALUES("$title", "$date", "$startTime","$endTime","$selectedremind","$repeat","$color" ,"new","0")',
      )
          .then((value) {
        debugPrint('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
        titlecontroller!.clear();
      }).catchError((error) {
        debugPrint('Error When Inserting New Record ${error.toString()}');
      });
    });
    return null;
  }

  getDataFromDatabase(Database database) {
    allTasks = [];
    completedTasks = [];
    uncompletedTasks = [];
    favoritTasks = [];
    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      allTasks = value;

      value.forEach((element) {
        if (element['status'] == 'completed') {
          completedTasks.add(element);
        } else if (element['status'] == 'uncompleted') {
          uncompletedTasks.add(element);
        }
        if (element['favorite'] == '1') {
          favoritTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
  }

  void updateFavoriteData({
    required String favorite,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET favorite = ? WHERE id = ?',
      [favorite, id],
    ).then((value) {
      getDataFromDatabase(database);
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
    });
  }

  DateTime selecteddate = DateTime.now();

  getDateFromUser(context) async {
    await showDatePicker(
      context: context,
      initialDate: selecteddate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value != null) {
        selecteddate = value;
        emit(GetDateFromUserState());
      } else {
        return;
      }
    });
  }

  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  getTimeFromUserS(context) async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()))
        .then((value) {
      RegExp regExp = RegExp(r'^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$');
      if (value == null) {
        return;
      } else {
        if (regExp.hasMatch(value.format(context))) {
          startTime = value.format(context);
          emit(GetTimeStartFromUserState());
        } else {
          var time = value.format(context);
          var temp = int.parse(time.split(':')[0]);
          String? t;
          if (temp >= 12 && temp < 24) {
            t = ' PM';
          } else {
            t = ' AM';
          }
          if (temp > 12) {
            temp = temp - 12;
            if (temp < 10) {
              time = time.replaceRange(0, 2, '0$temp');
              time += t;
            } else {
              time = time.replaceRange(0, 2, '$temp');
              time += t;
            }
          } else if (temp == 00) {
            time = time.replaceRange(0, 2, '12');
            time += t;
          } else {
            time += t;
          }

          startTime = time;
          emit(GetTimeStartFromUserState());
        }
      }
    });
  }

  getTimeFromUserE(context) async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(
                DateTime.now().add(const Duration(minutes: 15))))
        .then((value) {
      RegExp regExp1 = RegExp(r'^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$');
      if (value == null) {
        return;
      } else {
        if (regExp1.hasMatch(value.format(context))) {
          endTime = value.format(context);
          emit(GetTimeEndFromUserState());
        } else {
          var time = value.format(context);
          var temp = int.parse(time.split(':')[0]);
          String? t;
          if (temp >= 12 && temp < 24) {
            t = ' PM';
          } else {
            t = ' AM';
          }
          if (temp > 12) {
            temp = temp - 12;
            if (temp < 10) {
              time = time.replaceRange(0, 2, '0$temp');
              time += t;
            } else {
              time = time.replaceRange(0, 2, '$temp');
              time += t;
            }
          } else if (temp == 00) {
            time = time.replaceRange(0, 2, '12');
            time += t;
          } else {
            time += t;
          }

          endTime = time;
          emit(GetTimeEndFromUserState());
        }
      }
    });
  }

  List remindlist = [5, 10, 15, 20];
  int selectedremind = 5;
  void changeSelectedRemind({value}) {
    selectedremind = value;
    emit(GetReminderState());
  }

  String selectRepeat = 'none';
  List<String> repeatlist = ['none', 'daily', 'weekly', 'monthly'];

  void changeSelectedRepeat({value}) {
    selectRepeat = value;
    emit(GetRepeatState());
  }

  int selectcolor = 0;
  void changeColorRepeat({index}) {
    selectcolor = index;
    emit(ChangeColorState());
  }

  String selectedStatus = '';
  List<String> statuslist = ['Completed', 'UnCompleted', 'Favorite', 'Delete'];

  void changeSelectedstatus({value}) {
    selectedStatus = value;

    emit(ChangeStatusState());
  }
}
