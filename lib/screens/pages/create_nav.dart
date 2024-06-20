// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateNavPage extends StatefulWidget {
//   const CreateNavPage({super.key});

//   @override
//   State<CreateNavPage> createState() => _CreateNavPageState();
// }

// class _CreateNavPageState extends State<CreateNavPage> {
//   TextEditingController textFieldController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   File? _image;

//   Future<void> _getImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     textFieldController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: textFieldController,
//               decoration: InputDecoration(labelText: 'Text Field'),
//             ),
//             ElevatedButton(
//               onPressed: _getImage,
//               child: Text('Pick an image from gallery'),
//             ),
//             _image != null
//                 ? Image.file(_image!)
//                 : SizedBox(
//                     width: 0,
//                     height: 0,
//                   ),
//             TextField(
//               controller: descriptionController,
//               maxLines: 5, // Allows for multiple lines of text
//               decoration: InputDecoration(labelText: 'Description Text Area'),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add your create logic here
//                     String text = textFieldController.text;
//                     String description = descriptionController.text;
//                     // Perform actions with the entered data
//                   },
//                   child: Text('Create'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add your cancel logic here
//                     textFieldController.clear();
//                     descriptionController.clear();
//                     setState(() {
//                       _image = null;
//                     });
//                   },
//                   child: Text('Cancel'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
