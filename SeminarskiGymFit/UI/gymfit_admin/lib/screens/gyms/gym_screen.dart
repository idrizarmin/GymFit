import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/gym.dart';
import 'package:gymfit_admin/providers/gym_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';

class GymScreen extends StatefulWidget {
  const GymScreen({Key? key}) : super(key: key);

  @override
  State<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  final TextEditingController _nameController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();
  late GymProvider _gymProvider;
  List<Gym?> gyms = <Gym>[];

  @override
  void initState() {
    super.initState();
    _gymProvider =GymProvider();
    loadGyms();
   

   
  }

  void loadGyms() async {
    try {
     
      var gymResponse =
          await _gymProvider.getPaged();
      if (mounted) {
        setState(() {
          gyms = gymResponse;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  
  void EditGym(int id) async {
    try {
      var newGym = {
        // "id": id,
        // "content": _contentController.text,
        // "read": false,
        // "deleted": false,
        // "dateRead": null,
        // "sendOnDate": DateTime.now().toUtc().toIso8601String(),
        // "seen": null,
        // "userId": selectedUsers[0].id
      };
      var change = await _gymProvider.edit(newGym);
      if (change == "OK") {
      loadGyms();
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(bottom: defaultPadding / 2),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 18, 16, 50),
                  width: 2.0,
                ),
              ),
            ),
            child: const Header(pageTitle: "Teretana"),
          ),
          const SizedBox(
            height: 16,
          ),
         buildButtons(context),
          SizedBox(
            height: 16,
          ),
            buildGymInfo(gyms[0]!),
           SizedBox(
            height: 1,
          ),
          
        ]),
      ),
    );
  }
  

 
  Row buildButtons(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: secondaryColor,
                              title: Text("Dodaj rezervaciju"),
                              content: SingleChildScrollView(
                                child: EditGymForm(gymToEdit: gyms[0]),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Zatvori")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        //izjena podataka teretane
                                      }
                                    },
                                    child: Text("Spremi"))
                              ],
                            );
                          });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Izmjeni',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      loadGyms();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Osvježi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
  }
// : (userToEdit != null &&
//                                 userToEdit.profilePhoto != null)
//                             ? Image.memory(
//                                 Uint8List.fromList(base64Decode(
//                                     userToEdit.profilePhoto!.data)),
//                                 width: 230,
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                               )
Widget buildGymInfo(Gym gym) {
  return DataTable(
    columns: [
      DataColumn(label: Text('Property')),
      DataColumn(label: Text('Value')),
    ],
    rows: [
      DataRow(cells: [
        DataCell(Text('Name')),
        DataCell(Text(gym.name)),
      ]),
      DataRow(cells: [
        DataCell(Text('Description')),
        DataCell(Text(gym.description ?? '')),
      ]),
      DataRow(cells: [
        DataCell(Text('Website')),
        DataCell(Text(gym.website ?? '')),
      ]),
      DataRow(cells: [
        DataCell(Text('Address')),
        DataCell(Text(gym.address ?? '')),
      ]),
      DataRow(cells: [
        DataCell(Text('Phone Number')),
        DataCell(Text(gym.phoneNumber ?? '')),
      ]),
    ],
  );
}
Widget EditGymForm({
    bool isEditing = false,
    Gym? gymToEdit,
  }) {
    if (gymToEdit != null) {
    } else {}

    return Container(
      height: 450,
      width: 950,
      color: secondaryColor,
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          decoration:
                              InputDecoration(labelText: 'Naziv teretane'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Obavezan unos!';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      
                    ],
                  ),
                 
                  SizedBox(
                    height: 20,
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


//   Expanded buildDataView(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: ConstrainedBox(
//           constraints:
//               BoxConstraints(minWidth: MediaQuery.of(context).size.width),
//           child: Container(
//               decoration: BoxDecoration(
//                 border:
//                     Border.all(color: Colors.white, style: BorderStyle.solid),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: DataTable(
//                 dataRowColor: MaterialStateProperty.all(
//                     const Color.fromARGB(42, 241, 241, 241)),
//                 columns: [
//                   DataColumn(
//                       label: Checkbox(
//                           value: isAllSelected,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isAllSelected = value ?? false;
//                               notifications.forEach((notificationItem) {
//                                 notificationItem.isSelected = isAllSelected;
//                               });

//                               if (!isAllSelected) {
//                                 selectedNotifications.clear();
//                               } else {
//                                 selectedNotifications =
//                                     List.from(notifications);
//                               }
//                             });
//                           })),
//                   DataColumn(
//                     label: Expanded(
//                       child: Text(
//                         "Content",
//                         style: TextStyle(fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "Korisnik",
//                       style: TextStyle(fontStyle: FontStyle.normal),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "Datum slanja",
//                       style: TextStyle(fontStyle: FontStyle.normal),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Container(
//                       child: Text(
//                         "Viđeno",
//                         style: TextStyle(fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ),
//                 ],
//                 rows: notifications.map((notificationItem) {
//                   return DataRow(
//                     cells: [
//                       DataCell(
//                         Checkbox(
//                           value: notificationItem.isSelected,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               notificationItem.isSelected = value ?? false;
//                               if (notificationItem.isSelected == true) {
//                                 selectedNotifications.add(notificationItem);
//                               } else {
//                                 selectedNotifications.remove(notificationItem);
//                               }
//                               isAllSelected = notifications.every(
//                                   (notification) => notification.isSelected);
//                             });
//                           },
//                         ),
//                       ),
//                       DataCell(Text(notificationItem.content)),
//                       DataCell(
//                         Text(
//                             '${notificationItem.user!.firstName} ${notificationItem.user!.lastName}?? '
//                             ' '),
//                       ),
//                       DataCell(
//                         Text(
//                           notificationItem.SendOnDate != null
//                               ? DateFormat('dd/MM/yyyy')
//                                   .format(notificationItem.SendOnDate!)
//                               : '--',
//                         ),
//                       ),
//                       DataCell(Container(
//                         alignment: Alignment.centerLeft,
//                         child: notificationItem.Read == true
//                             ? Icon(
//                                 Icons.check_outlined,
//                                 color: primaryColor,
//                               )
//                             : Icon(
//                                 Icons.close_outlined,
//                                 color: Colors.red,
//                               ),
//                       )),
//                     ],
//                   );
//                 }).toList(),
//               )),
//         ),
//       ),
//     );
//   }
}
