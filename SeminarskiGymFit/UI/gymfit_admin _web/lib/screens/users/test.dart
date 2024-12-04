// import 'dart:typed_data';
// import 'dart:html' as html; // Za web podršku
// import 'package:flutter/foundation.dart'; // Za provjeru platforme
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Za mobile platforme

// class FilePickerWidget extends StatefulWidget {
//   @override
//   _FilePickerWidgetState createState() => _FilePickerWidgetState();
// }

// class _FilePickerWidgetState extends State<FilePickerWidget> {
//   final ValueNotifier<Uint8List?> _pickedFileNotifier = ValueNotifier<Uint8List?>(null);

//   Future<void> _pickImage() async {
//     if (kIsWeb) {
//       // Implementacija za web
//       final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//       uploadInput.accept = 'image/*'; // Ograničenje na slike
//       uploadInput.click();

//       uploadInput.onChange.listen((event) {
//         final files = uploadInput.files;
//         if (files != null && files.isNotEmpty) {
//           final reader = html.FileReader();
//           reader.readAsArrayBuffer(files[0]);
//           reader.onLoadEnd.listen((_) {
//             setState(() {
//               _pickedFileNotifier.value = reader.result as Uint8List?;
//             });
//           });
//         }
//       });
//     } else {
//       // Implementacija za druge platforme
//       final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() async {
//           _pickedFileNotifier.value = await pickedFile.readAsBytes();
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('File Picker Example')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ValueListenableBuilder<Uint8List?>(
//               valueListenable: _pickedFileNotifier,
//               builder: (context, value, child) {
//                 if (value != null) {
//                   return Image.memory(value, height: 200, width: 200, fit: BoxFit.cover);
//                 }
//                 return Text('No image selected');
//               },
//             ),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }