import 'package:flutter/material.dart';
import 'package:my_diary/Diaries_HomeLayout/cubit.dart';

import 'Reusable_FormField.dart';

class MyDiaryItem extends StatefulWidget {
  late Map<dynamic, dynamic> model;

  MyDiaryItem({Key? key, required this.model}) : super(key: key);

  @override
  State<MyDiaryItem> createState() => _MyDiaryItemState();
}

class _MyDiaryItemState extends State<MyDiaryItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: const Center(
            child: Text(
          'Delete',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      key: Key(UniqueKey().toString()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(
                    '${widget.model['id']}',
                    style: const TextStyle(fontSize: 30),
                  ),
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.model['title']}',
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      '${widget.model['date']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        onTap: () {
                          DiariesCubit cubit = DiariesCubit.get(context);

                          showModalBottomSheet<dynamic>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext builder) {
                              var editTaskBodyController =
                                  TextEditingController(
                                      text: widget.model['body']);
                              return SizedBox(
                                height: 700,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                child: Column(
                                                  children: const [
                                                    Icon(Icons.save),
                                                    Text('Save'),
                                                  ],
                                                ),
                                                onTap: () async {
                                                  final updatedData =
                                                      await DiariesCubit.get(
                                                              context)
                                                          .updateData(
                                                    updateDiaryTitle:
                                                        widget.model['title'],
                                                    updatedDiaryBody:
                                                        editTaskBodyController
                                                            .text,
                                                    id: widget.model['id'],
                                                  );
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    widget.model = updatedData;
                                                  });

                                                  // final updatedData =
                                                  //     await DiariesCubit.get(
                                                  //             context)
                                                  //         .updateData(
                                                  //   updateDiaryTitle:
                                                  //       widget.model['title'],
                                                  //   updatedDiaryBody:
                                                  //       editTaskBodyController
                                                  //           .text,
                                                  //   id: widget.model['id'],
                                                  // );
                                                  // Navigator.pop(context);
                                                  // setState(() {
                                                  //   widget.model = updatedData!;
                                                  // });
                                                }),
                                            const Expanded(
                                              child: SizedBox(
                                                width: 15,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Title : ${widget.model['title']}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        ReusableFormField(
                                          fieldWidth: 400,
                                          fieldMaxLines: 1000000,
                                          fieldMinLines: 27,
                                          fieldHeight: 2000,
                                          formFieldController:
                                              editTaskBodyController,
                                          formFieldTextType: TextInputType.text,
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
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        DiariesCubit.get(context).deleteDiariesItem(
          id: widget.model['id'],
          // userId: DiariesCubit.get(context).userId ?? "",
        );
      },
      confirmDismiss: (direction) {
        return Future.value(direction == DismissDirection.endToStart);
      },
    );
  }
}
