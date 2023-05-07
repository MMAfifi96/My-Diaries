import 'package:flutter/material.dart';
import 'package:my_diary/Diaries_HomeLayout/cubit.dart';

import 'Reusable_FormField.dart';

// Widget reusableButton({
//   double buttonHeight = 50,
//   required double buttonWidth,
//   required String buttonText,
//   required Color buttonBackgroundColor,
//   Color buttonTextColor = Colors.white,
//   required VoidCallback buttonOnPressed,
// }) =>
//     Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: buttonBackgroundColor,
//       ),
//       width: buttonWidth,
//       height: buttonHeight,
//       child: MaterialButton(
//         child: Text(
//           buttonText,
//           style: TextStyle(
//               color: buttonTextColor,
//               fontSize: 20,
//               fontWeight: FontWeight.bold),
//         ),
//         onPressed: buttonOnPressed,
//       ),
//     );
//--------------------------------------------------------

// Widget reusableFormField({
//   required TextEditingController formFieldController,
//   required TextInputType formFieldTextType,
//   void Function(String?)? formFieldOnSubmitted,
//   void Function(String?)? formFieldOnChanged,
//   required final FormFieldValidator<String>? formFieldValidator,
//   required String formFieldLabelText,
//   required IconData formFieldPrefixIcon,
//   IconData? formFieldSuffixIcon,
//   String? hintName,
//   double? fieldHeight,
//   double? fieldWidth,
//   int? fieldMinLines,
//   int? fieldMaxLines,
//   bool isPassword = false,
//   VoidCallback? formFieldSuffixIconPressed,
//   VoidCallback? formFieldOnTap,
// }) =>
//     SizedBox(
//       height: fieldHeight,
//       width: fieldWidth,
//       child: TextFormField(
//         decoration: InputDecoration(
//           labelText: formFieldLabelText,
//           hintText: hintName,
//           prefixIcon: Icon(formFieldPrefixIcon),
//           suffixIcon: formFieldSuffixIcon != null
//               ? GestureDetector(
//                   onTap: formFieldSuffixIconPressed,
//                   child: Icon(formFieldSuffixIcon))
//               : null,
//           border: const OutlineInputBorder(),
//         ),
//         obscureText: isPassword,
//         validator: formFieldValidator,
//         controller: formFieldController,
//         keyboardType: formFieldTextType,
//         onFieldSubmitted: formFieldOnSubmitted,
//         onChanged: formFieldOnChanged,
//         onTap: formFieldOnTap,
//         minLines: fieldMinLines,
//         maxLines: fieldMaxLines,
//       ),
//     );
//------------------------------------------------------------
// Widget buildDiaryItem(Map model, context) => Dismissible(
//       key: Key(UniqueKey().toString()),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   child: Text(
//                     '${model['id']}',
//                     style: const TextStyle(fontSize: 30),
//                   ),
//                   radius: 30,
//                 ),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '${model['title']}',
//                       style: const TextStyle(fontSize: 30),
//                     ),
//                     Text(
//                       '${model['date']}',
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//                 const Expanded(child: SizedBox()),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.black,
//                           size: 24.0,
//                         ),
//                         onTap: () {
//                           DiariesCubit cubit = DiariesCubit.get(context);
//
//                           showModalBottomSheet<dynamic>(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             isScrollControlled: true,
//                             context: context,
//                             builder: (BuildContext builder) {
//                               var editTaskBodyController =
//                                   TextEditingController(text: model['body']);
//                               return SizedBox(
//                                 height: 700,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             GestureDetector(
//                                                 child: Column(
//                                                   children: const [
//                                                     Icon(Icons.save),
//                                                     Text('Save'),
//                                                   ],
//                                                 ),
//                                                 onTap: () {
//                                                   // cubit
//                                                   //     .updateData(
//                                                   //   id: model['id'],
//                                                   //   taskBody: editTaskBodyController.text,
//                                                   // taskTitle: editTaskTitleController.text,
//                                                   // )
//                                                   //     .then((value) {
//                                                   //   cubit.DiariesTable = value;
//                                                   // });
//                                                 }),
//                                             const Expanded(
//                                               child: SizedBox(
//                                                 width: 15,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 'Title : ${model['title']}',
//                                                 style: const TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 30,
//                                         ),
//                                         ReusableFormField(
//                                           fieldWidth: 400,
//                                           fieldMaxLines: 1000000,
//                                           fieldMinLines: 27,
//                                           fieldHeight: 2000,
//                                           formFieldController:
//                                               editTaskBodyController,
//                                           formFieldTextType: TextInputType.text,
//                                           formFieldLabelText: 'Body',
//                                           formFieldPrefixIcon:
//                                               Icons.import_contacts,
//                                           formFieldValidator: (value) {
//                                             if (value!.isEmpty) {
//                                               return 'please enter content to your diary'
//                                                   .toUpperCase();
//                                             }
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         // DiariesCubit.get(context).updateData(
//                         //   taskTitle: model['title'],
//                         //   taskBody: model['body'],
//                         //   id: model['id'],
//                         // );
//                         // print('Update Pressed');
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       onDismissed: (direction) {
//         DiariesCubit.get(context).deleteDiariesItem(id: model['id']);
//       },
//       confirmDismiss: (direction) {
//         return Future.value(direction == DismissDirection.endToStart);
//       },
//     );
