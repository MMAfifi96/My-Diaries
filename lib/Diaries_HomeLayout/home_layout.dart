import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_diary/Login&Signup/login_screen.dart';
import 'package:my_diary/Reusable_Components/Reusable_FormField.dart';
import 'package:my_diary/Reusable_Components/components.dart';
import 'package:my_diary/Reusable_Components/Reusable_Button.dart';
import 'package:my_diary/Diaries_HomeLayout/cubit.dart';
import 'package:my_diary/Diaries_HomeLayout/states.dart';
import 'package:sqflite/sqflite.dart';

import '../Reusable_Components/Diary_Item.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var addNewTaskTitleController = TextEditingController();
  var addNewTaskBodyController = TextEditingController();
  var addNewTaskTimeController = TextEditingController();
  var addNewTaskDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DiariesCubit()..createDatabase(),
      child: BlocConsumer<DiariesCubit, DiariesStates>(
        listener: (BuildContext context, DiariesStates state) {},
        builder: (BuildContext context, DiariesStates state) {
          DiariesCubit cubit = DiariesCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Row(
                children: [
                  const Center(child: Text('My Diaries')),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.logout,
                          size: 27.0,
                        ),
                        Text(
                          'Log out',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Add New Diary',
                            style: TextStyle(
                              fontSize: 25,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Icon(
                            Icons.add_circle_outline,
                            size: 27.0,
                          ),
                        ],
                      ),
                      onTap: () {
                        scaffoldKey.currentState?.showBottomSheet(
                          (context) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: Column(
                                                  children: const [
                                                    Icon(Icons.save),
                                                    Text('Save'),
                                                  ],
                                                ),
                                                onTap: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cubit
                                                        .insertInDatabase(
                                                      newTaskDate:
                                                          addNewTaskDateController
                                                              .text,
                                                      newTaskTitle:
                                                          addNewTaskTitleController
                                                              .text,
                                                      newTaskBody:
                                                          addNewTaskBodyController
                                                              .text,
                                                      newTaskTime:
                                                          addNewTaskTimeController
                                                              .text,
                                                      // userId: '',
                                                    )
                                                        .then((value) {
                                                      cubit
                                                          .getDataFromDatabase(
                                                              cubit.database)
                                                          .then((value) {
                                                        cubit.DiariesTable =
                                                            value;
                                                        print(
                                                            cubit.DiariesTable);
                                                        print('Save Pressed');
                                                        Navigator.pop(context);
                                                      });
                                                      print(
                                                          'database opened ==========');
                                                    });
                                                  }
                                                },
                                              ),
                                              const Expanded(child: SizedBox()),
                                              GestureDetector(
                                                child: Column(
                                                  children: const [
                                                    Icon(Icons.close),
                                                    Text('Close'),
                                                  ],
                                                ),
                                                onTap: () {
                                                  print('Close Pressed');
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          ReusableFormField(
                                            formFieldController:
                                                addNewTaskDateController,
                                            formFieldTextType:
                                                TextInputType.datetime,
                                            formFieldLabelText: 'Date',
                                            formFieldPrefixIcon:
                                                Icons.calendar_month,
                                            formFieldOnTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2200-01-01'),
                                              ).then((value) {
                                                addNewTaskDateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!);
                                              });
                                            },
                                            formFieldValidator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please chose date to your diary'
                                                    .toUpperCase();
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          ReusableFormField(
                                            formFieldController:
                                                addNewTaskTimeController,
                                            formFieldTextType:
                                                TextInputType.datetime,
                                            formFieldLabelText: 'Time',
                                            formFieldPrefixIcon: Icons.timer,
                                            formFieldOnTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now())
                                                  .then((value) {
                                                addNewTaskTimeController.text =
                                                    value!.format(context);
                                                print(value
                                                    .format(context)
                                                    .toUpperCase());
                                              });
                                            },
                                            formFieldValidator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please chose time to your diary'
                                                    .toUpperCase();
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          ReusableFormField(
                                            formFieldController:
                                                addNewTaskTitleController,
                                            formFieldTextType:
                                                TextInputType.text,
                                            formFieldLabelText: 'Title',
                                            formFieldPrefixIcon: Icons.title,
                                            formFieldValidator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter title to your diary'
                                                    .toUpperCase();
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          ReusableFormField(
                                            fieldMaxLines: 1000000,
                                            fieldMinLines: 9,
                                            fieldHeight: 120,
                                            formFieldController:
                                                addNewTaskBodyController,
                                            formFieldTextType:
                                                TextInputType.text,
                                            formFieldLabelText: 'Body',
                                            formFieldPrefixIcon:
                                                Icons.import_contacts,
                                            formFieldValidator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter content to your diary'
                                                    .toUpperCase();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 700,
                      child: cubit.DiariesTable.isEmpty
                          ? const Center(child: Text('No Diaries Added Yet'))
                          : ListView.separated(
                              // Less Memory usage for the listview Builder ---
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              // ----------------------------------------------
                              itemBuilder: (context, index) =>
                                  MyDiaryItem(model: cubit.DiariesTable[index]),
                              separatorBuilder: (context, index) => Container(
                                color: Colors.grey[400],
                                width: double.infinity,
                                height: 1,
                              ),
                              itemCount: cubit.DiariesTable.length,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
