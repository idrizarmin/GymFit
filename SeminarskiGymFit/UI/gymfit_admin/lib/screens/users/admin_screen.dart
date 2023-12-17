import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/searchObjects/user_search.dart';
import 'package:gymfit_admin/models/user.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<User> users = <User>[];
  List<User> selectedUsers = <User>[];
  late UserProvider _userProvider;
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int? selectedGender;
  bool _isActive = false;
  bool _isVerified = false;
  bool isAllSelected = false;
  int currentPage = 1;
  int itemsPerPage = 100000000;
  File? _image;
  XFile? _pickedFile;
  final _picker = ImagePicker();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    loadUsers(
        UserSearchObject(name: _searchController.text, PageSize: itemsPerPage));

    _searchController.addListener(() {
      final searchQuery = _searchController.text;
      loadUsers(UserSearchObject(name: searchQuery));
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        _image = File(pickedFile.path);
      });
    }
  }

  void loadUsers(UserSearchObject searchObject) async {
    try {
      var usersResponse =
          await _userProvider.getAdminsPaged(searchObject: searchObject);
      setState(() {
        users = usersResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void InsertUser() async {
    try {
      var imageFile = File(_image!.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String imageBase64 = base64Encode(imageBytes);

      var newUser = {
        "id": 0,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phoneNumber": _phoneNumberController.text,
        "address": null,
        "professionalTitle": null,
        "gender": selectedGender,
        "birthDate": _birthDateController.text,
        "role": 0,
        "lastSignInAt": DateTime.now().toUtc().toIso8601String(),
        "isVerified": _isVerified,
        "isActive": _isActive,
        "profilePhoto": imageBase64,
      };
      var user = await _userProvider.insert(newUser);
      if (user == "OK") {
        Navigator.of(context).pop();
        loadUsers(UserSearchObject(name: _searchController.text));
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void EditUser(int id) async {
    try {
      var imageFile = File(_image!.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String imageBase64 = base64Encode(imageBytes);

      var newUser = {
        "id": id,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phoneNumber": _phoneNumberController.text,
        "address": null,
        "professionalTitle": null,
        "gender": selectedGender,
        "dateOfBirth": _birthDateController.text,
        "role": 0,
        "lastSignInAt": DateTime.now().toUtc().toIso8601String(),
        "isVerified": _isVerified,
        "isActive": _isActive,
        "profilePhoto": imageBase64,
      };
      var user = await _userProvider.edit(newUser);
      if (user == "OK") {
        loadUsers(UserSearchObject(name: _searchController.text));
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void DeleteUser(int id) async {
    try {
      var user = await _userProvider.delete(id);
      if (user == "OK") {
        loadUsers(UserSearchObject(name: _searchController.text));
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  Widget displayImage(String base64String) {
    if (base64String == null) {
      return Placeholder();
    } else {
      List<int> bytes = base64Decode(base64String);

      return Image.memory(
        Uint8List.fromList(bytes),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  child: const Header(pageTitle: "Administratori")),
              const SizedBox(height: 16.0),
              buildButtons(context),
              const SizedBox(
                height: 10,
              ),
              buildDataList(context),
              const SizedBox(
                height: 10,
              ),
              buildPagination(),
            ])));
  }

  Row buildButtons(BuildContext context) {
    return Row(
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
                    title: Text("Dodaj korisnika"),
                    content: SingleChildScrollView(
                      child: AddUserForm(),
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
                              InsertUser();
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
                Icons.add_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Dodaj',
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
            if (selectedUsers.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content: Text(
                          "Morate odabrati barem jednog klijenta za uređivanje"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: myButtonColor),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  });
            } else if (selectedUsers.length > 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content: Text(
                          "Odaberite samo jednog klijenta kojeg želite urediti"),
                      actions: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok"))
                      ],
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: secondaryColor,
                      title: Text("Uredi klijenta"),
                      content: AddUserForm(
                          isEditing: true, userToEdit: selectedUsers[0]),
                      actions: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Zatvori")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              EditUser(selectedUsers[0].id);
                              selectedUsers = [];
                              Navigator.of(context).pop();
                            },
                            child: Text("Spremi")),
                      ],
                    );
                  });
            }
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
          onPressed: selectedUsers.isEmpty
              ? () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Upozorenje"),
                            content: Text(
                                "Morate odabrati klijenta kojeg želite obrisati."),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: myButtonColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ]);
                      });
                }
              : () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Izbriši klijenta!"),
                          content: SingleChildScrollView(
                            child: Text(
                                "Da li ste sigurni da želite obrisati klijenta?"),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Odustani"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                for (User n in selectedUsers) {
                                  DeleteUser(n.id);
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text("Obriši"),
                            ),
                          ],
                        );
                      });
                },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_forever_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Obriši',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildDataList(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DataTable(
                dataRowHeight: 100,
                dataRowColor: MaterialStateProperty.all(
                    const Color.fromARGB(42, 241, 241, 241)),
                columns: [
                  DataColumn(
                      label: Checkbox(
                          value: isAllSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              isAllSelected = value ?? false;
                              users.forEach((userItem) {
                                userItem.isSelected = isAllSelected;
                              });
                              if (!isAllSelected) {
                                selectedUsers.clear();
                              } else {
                                selectedUsers = List.from(users);
                              }
                            });
                          })),
                  const DataColumn(
                    label: Expanded(child: Text('Ime i prezime')),
                  ),
                  const DataColumn(
                    label: Text('Slika'),
                  ),
                  const DataColumn(
                    label: Expanded(child: Text('Broj telefona')),
                  ),
                  const DataColumn(
                    label: Text('Email'),
                  ),
                  const DataColumn(
                    label: Text('Spol'),
                  ),
                  const DataColumn(
                    label: Text('Aktivan'),
                  ),
                  const DataColumn(
                    label: Text('Verifikovan'),
                  ),
                ],
                rows: users
                        .map((User userItem) => DataRow(cells: [
                              DataCell(
                                Checkbox(
                                  value: userItem.isSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      userItem.isSelected = value ?? false;
                                      if (userItem.isSelected == true) {
                                        selectedUsers.add(userItem);
                                      } else {
                                        selectedUsers.remove(userItem);
                                      }
                                      isAllSelected =
                                          users.every((u) => u.isSelected);
                                    });
                                  },
                                ),
                              ),
                              DataCell(Text(
                                  ("${userItem.firstName.toString() ?? ""} ${userItem.lastName.toString() ?? ""}"))),
                              DataCell(Row(
                                children: [
                                  if (userItem.photo != null)
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Image.memory(
                                        Uint8List.fromList(base64Decode(
                                            userItem.photo!.data!)),
                                        width: 40,
                                        height: 40,
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Image.asset(
                                          'assets/images/user1.jpg',
                                          width: 70,
                                          height: 100),
                                    ),
                                ],
                              )),
                              DataCell(Center(
                                child: Text(
                                    userItem.phoneNumber?.toString() ?? ""),
                              )),
                              DataCell(Text(userItem.email.toString() ?? "")),
                              DataCell(Text(
                                  userItem.gender == 0 ? "Male" : "Female")),
                              DataCell(Container(
                                alignment: Alignment.center,
                                child: userItem.isActive == true
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: primaryColor,
                                      )
                                    : Icon(
                                        Icons.close_outlined,
                                        color: Colors.red,
                                      ),
                              )),
                              DataCell(Container(
                                alignment: Alignment.center,
                                child: userItem.isVerified == true
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: primaryColor,
                                      )
                                    : Icon(
                                        Icons.close_outlined,
                                        color: Colors.red,
                                      ),
                              )),
                            ]))
                        .toList() ??
                    []),
          ),
        ),
      ),
    );
  }

  Widget AddUserForm({bool isEditing = false, User? userToEdit}) {
    if (userToEdit != null) {
      _firstNameController.text = userToEdit.firstName ?? '';
      _lastNameController.text = userToEdit.lastName ?? '';
      _emailController.text = userToEdit.email ?? '';
      _phoneNumberController.text = userToEdit.phoneNumber ?? '';
      _birthDateController.text = userToEdit.dateOfBirth ?? '';
      selectedGender = userToEdit.gender;
      _isActive = userToEdit.isActive;
      _isVerified = userToEdit.isVerified;
      _passwordController.text = '';
      _pickedFile = null;
    } else {
      _firstNameController.text = '';
      _lastNameController.text = '';
      _emailController.text = '';
      _phoneNumberController.text = '';
      _birthDateController.text = '';
      selectedGender = null;
      _isVerified = false;
      _isActive = false;
      _passwordController.text = '';
      _pickedFile = null;
    }


    return Container(
      height: 450,
      width: 950,
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
                child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 180,
                    color: primaryColor,
                    child: (_pickedFile != null)
                        ? Image.file(
                            File(_pickedFile!.path),
                            width: 230,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : (userToEdit != null &&
                                userToEdit.photo != null)
                            ? Image.memory(
                                Uint8List.fromList(base64Decode(
                                    userToEdit.photo!.data!)),
                                width: 230,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : const Text('Please select an image'),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: SizedBox(
                      width: 150, // Širina dugmeta
                      height: 35, // Visina dugmeta
                      child: ElevatedButton(
                        onPressed: () => _pickImage(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Zaobljenost rubova
                          ),
                        ),
                        child: Text('Select An Image',
                            style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  )
                ]),
              ),
            )),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'Ime'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite ime!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Prezime'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite prezime!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite email!';
                      }
                      final emailPattern = RegExp(r'^\w+@[\w-]+(\.[\w-]+)+$');
                      if (!emailPattern.hasMatch(value)) {
                        return 'Unesite ispravan gmail email!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'Broj'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite broj!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Sifra'),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _birthDateController,
                    decoration: InputDecoration(
                      labelText: 'Datum',
                      hintText: 'Odaberite datum', // Dodajte hintText ovde
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2101),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                            _birthDateController.text =
                                DateFormat('yyyy-MM-dd').format(date);
                          });
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite datum!';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<int>(
                    value: selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem<int>(
                        value: null,
                        child: Text('Odaberi spol'),
                      ),
                      DropdownMenuItem<int>(
                        value: 0,
                        child: Text('Muški'),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Ženski'),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Spol',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Unesite spol!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _isActive,
                        onChanged: (bool? value) {
                          _isActive = !_isActive;
                        },
                      ),
                      Text('Aktivan'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _isVerified,
                        onChanged: (bool? value) {
                          _isVerified = !_isVerified;
                        },
                      ),
                      Text('Verifikovan'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPagination() {
    final endIndex = (currentPage * itemsPerPage).clamp(0, users.length);
    final hasNextPage = endIndex < users.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: myButtonColor),
          onPressed: () {
            if (currentPage > 1) {
              setState(() {
                currentPage--;
                loadUsers(UserSearchObject());
              });
            }
          },
          child: const Icon(Icons.arrow_left_outlined),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: myButtonColor),
          onPressed: () {
            if (hasNextPage) {
              setState(() {
                currentPage++;
                loadUsers(UserSearchObject());
              });
            }
          },
          child: const Icon(Icons.arrow_right_outlined),
        ),
      ],
    );
  }
}
