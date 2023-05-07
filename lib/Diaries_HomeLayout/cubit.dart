// import 'dart:ffi';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_diary/Login&Signup/Models/UserModel.dart';
// import 'package:my_diary/Diaries_HomeLayout/states.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DiariesCubit extends Cubit<DiariesStates> {
//   late Database database;
//   List<Map> DiariesTable = [];
//   String? userId;
//
//   DiariesCubit() : super(DiariesInitialState());
//   static DiariesCubit get(context) => BlocProvider.of(context);
//
//   //original
//   // void createDatabase() {
//   //   openDatabase(
//   //     'diaries.db',
//   //     version: 1,
//   //     onCreate: (database, version) {
//   //       print('database created ==========');
//   //       database
//   //           .execute(
//   //               'CREATE TABLE DiariesTable (id INTEGER PRIMARY KEY, title TEXT , time TEXT , body TEXT , date TEXT , userId TEXT )')
//   //           .then((value) {
//   //         print('Table Created');
//   //       }).catchError((error) {
//   //         print(
//   //             'Error happened while (creating) table ${error.toString().toUpperCase()}');
//   //       });
//   //     },
//   //     onOpen: (database) {
//   //       getDataFromDatabase(database).then((value) {
//   //         DiariesTable = value;
//   //         print(DiariesTable);
//   //         emit(DiariesGetDatabaseState());
//   //       });
//   //       print('database opened ==========');
//   //     },
//   //   ).then((value) {
//   //     database = value;
//   //     emit(DiariesCreateDatabaseState());
//   //   });
//   // }
// //----------------------------------------
//
//   void createDatabase() {
//     openDatabase(
//       'diaries.db',
//       version: 1,
//       onCreate: (database, version) {
//         print('database created ==========');
//         database
//             .execute(
//           'CREATE TABLE DiariesTable (id INTEGER PRIMARY KEY, title TEXT, time TEXT, body TEXT, date TEXT, userId TEXT)',
//         )
//             .then((value) {
//           print('Table Created');
//         }).catchError((error) {
//           print(
//             'Error happened while (creating) table ${error.toString().toUpperCase()}',
//           );
//         });
//       },
//       onOpen: (database) {
//         getDataFromDatabase(database, userId!).then((value) {
//           DiariesTable = value;
//           print(DiariesTable);
//           emit(DiariesGetDatabaseState());
//         });
//         print('database opened ==========');
//       },
//     ).then((value) {
//       database = value;
//       emit(DiariesCreateDatabaseState());
//     });
//   }
//
// // original
// //   insertInDatabase({
// //     required String newTaskDate,
// //     required String newTaskTime,
// //     required String newTaskTitle,
// //     required String newTaskBody,
// //   }) async {
// //     await database.transaction((txn) {
// //       txn
// //           .rawInsert(
// //               'INSERT INTO DiariesTable(date, time, title, body) VALUES("$newTaskDate", "$newTaskTime", "$newTaskTitle", "$newTaskBody")')
// //           // , userId -------- , "$userId"
// //           .then((value) {
// //         print('$value inserted successfully');
// //         emit(DiariesInsertDatabaseState());
// //         getDataFromDatabase(database).then((value) {
// //           DiariesTable = value;
// //           print(DiariesTable);
// //           emit(DiariesGetDatabaseState());
// //         });
// //       }).catchError((error) {
// //         print(
// //             'Error happened while (inserting) in table ${error.toString().toUpperCase()}');
// //       });
// //       return Future(() => null);
// //     });
// //   }
//   //--------------------------
//
//   insertInDatabase({
//     required String newTaskDate,
//     required String newTaskTime,
//     required String newTaskTitle,
//     required String newTaskBody,
//     required String userId, // add userId parameter here
//   }) async {
//     await database.transaction((txn) {
//       txn
//           .rawInsert(
//               'INSERT INTO DiariesTable(date, time, title, body, userId) VALUES("$newTaskDate", "$newTaskTime", "$newTaskTitle", "$newTaskBody", "$userId")') // pass userId as an argument to the query
//           .then((value) {
//         print('$value inserted successfully');
//         emit(DiariesInsertDatabaseState());
//         getDataFromDatabase(database, userId).then((value) {
//           DiariesTable = value;
//           print(DiariesTable);
//           emit(DiariesGetDatabaseState());
//         });
//       }).catchError((error) {
//         print(
//             'Error happened while (inserting) in table ${error.toString().toUpperCase()}');
//       });
//       return Future(() => null);
//     });
//   }
//
// //original
// //   Future<List<Map>> getDataFromDatabase(database) async {
// //     emit(DiariesGetDatabaseLoadingState());
// //     return await database.rawQuery('SELECT * FROM DiariesTable');
// //     //WHERE userId = "$userId"
// //   }
//   //------------------------------
//
//   Future<List<Map>> getDataFromDatabase(database, String userId) async {
//     emit(DiariesGetDatabaseLoadingState());
//     return await database.rawQuery(
//       'SELECT * FROM DiariesTable WHERE userId = "$userId"',
//     );
//   }
//
//   Future<List<Map>> getDataForUser(String userId) async {
//     emit(DiariesGetDatabaseLoadingState());
//     return await database
//         .rawQuery('SELECT * FROM DiariesTable WHERE userId = ?', [userId]);
//   }
//
//   deleteDiariesItem({
//     required int id,
//     required String userId,
//   }) async {
//     database
//         .rawDelete('DELETE FROM DiariesTable WHERE id = ?', [id]).then((value) {
//       emit(DiariesDeleteDatabaseState());
//
//       getDataFromDatabase(database, userId).then((value) {
//         DiariesTable = value;
//         print(DiariesTable);
//         emit(DiariesGetDatabaseState());
//       });
//     });
//   }
//
//   Future<Map<dynamic, dynamic>> updateData({
//     required String updateDiaryTitle,
//     required String updatedDiaryBody,
//     required int id,
//   }) async {
//     await database.rawUpdate(
//       'UPDATE DiariesTable SET title = ?, body = ? WHERE id = ?',
//       [updateDiaryTitle, updatedDiaryBody, id],
//     );
//     final newData = await database.query(
//       'DiariesTable',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     return newData.first;
//   }
// }

import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_diary/Login&Signup/Models/UserModel.dart';
import 'package:my_diary/Diaries_HomeLayout/states.dart';
import 'package:sqflite/sqflite.dart';

class DiariesCubit extends Cubit<DiariesStates> {
  late Database database;
  List<Map> DiariesTable = [];
  String? userId;

  DiariesCubit() : super(DiariesInitialState());
  static DiariesCubit get(context) => BlocProvider.of(context);

  void createDatabase() {
    openDatabase(
      'diaries.db',
      version: 1,
      onCreate: (database, version) {
        print('database created ==========');
        database
            .execute(
                //                'CREATE TABLE DiariesTable (id INTEGER PRIMARY KEY, title TEXT , time TEXT , body TEXT , date TEXT , userId TEXT )')
                'CREATE TABLE DiariesTable (id INTEGER PRIMARY KEY, title TEXT , time TEXT , body TEXT , date TEXT )')
            .then((value) {
          print('Table Created');
        }).catchError((error) {
          print(
              'Error happened while (creating) table ${error.toString().toUpperCase()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          DiariesTable = value;
          print(DiariesTable);
          emit(DiariesGetDatabaseState());
        });
        print('database opened ==========');
      },
    ).then((value) {
      database = value;
      emit(DiariesCreateDatabaseState());
    });
  }

  insertInDatabase({
    required String newTaskDate,
    required String newTaskTime,
    required String newTaskTitle,
    required String newTaskBody,
    // required String userId,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              //              'INSERT INTO DiariesTable(date, time, title, body, userId) VALUES("$newTaskDate", "$newTaskTime", "$newTaskTitle", "$newTaskBody", "$userId")')
              'INSERT INTO DiariesTable(date, time, title, body) VALUES("$newTaskDate", "$newTaskTime", "$newTaskTitle", "$newTaskBody")')
          .then((value) {
        print('$value inserted successfully');
        emit(DiariesInsertDatabaseState());
        getDataFromDatabase(database).then((value) {
          DiariesTable = value;
          print(DiariesTable);
          emit(DiariesGetDatabaseState());
        });
      }).catchError((error) {
        print(
            'Error happened while (inserting) in table ${error.toString().toUpperCase()}');
      });
      return Future(() => null);
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    emit(DiariesGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM DiariesTable');
  }

  deleteDiariesItem({
    required int id,
    // required String userId,
  }) async {
    // database.rawDelete('DELETE FROM DiariesTable WHERE id = ? AND userId = ?',

    database
        .rawDelete('DELETE FROM DiariesTable WHERE id = ?', [id]).then((value) {
      emit(DiariesDeleteDatabaseState());

      getDataFromDatabase(database).then((value) {
        DiariesTable = value;
        print(DiariesTable);
        emit(DiariesGetDatabaseState());
      });
    });
  }

  Future<Map<dynamic, dynamic>> updateData({
    required String updateDiaryTitle,
    required String updatedDiaryBody,
    required int id,
  }) async {
    await database.rawUpdate(
      'UPDATE DiariesTable SET title = ?, body = ? WHERE id = ?',
      [updateDiaryTitle, updatedDiaryBody, id],
    );
    final newData = await database.query(
      'DiariesTable',
      where: 'id = ?',
      whereArgs: [id],
    );
    return newData.first;
  }

// Future<Map<dynamic, dynamic>?> updateData({
  //   required String updateDiaryTitle,
  //   required String updatedDiaryBody,
  //   required int id,
  // }) async {
  //   await database.rawUpdate(
  //     'UPDATE DiariesTable SET title = ?, body = ? WHERE id = ?',
  //     [updateDiaryTitle, updatedDiaryBody, id],
  //   );
  //   // final newData = await database.query(
  //   //   'DiariesTable',
  //   //   where: 'id = ?',
  //   //   whereArgs: [id],
  //   // );
  //   // return newData.first;
  //   return null;
  // }
}
