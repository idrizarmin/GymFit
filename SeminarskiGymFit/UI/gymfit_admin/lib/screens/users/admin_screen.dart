import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/searchObjects/user_search.dart';
import 'package:gymfit_admin/models/user.dart';
import 'package:gymfit_admin/providers/photo_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:gymfit_admin/utils/authorization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<User> users = <User>[];
  List<User> selectedUsers = <User>[];
  late UserProvider _userProvider;
  late PhotoProvider _photoProvider;
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  ValueNotifier<File?> _pickedFileNotifier = ValueNotifier(null);
  late ValueNotifier<bool> _isActiveNotifier;
  late ValueNotifier<bool> _isVerifiedNotifier;
  DateTime selectedDate = DateTime.now();
  int? selectedGender;
  bool _isActive = false;
  bool _isVerified = false;
  bool isAllSelected = false;
  int currentPage = 1;
  int pageSize = 20;
  int hasNextPage = 0;
  File? _pickedFile;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _photoProvider = context.read<PhotoProvider>();
    _isActiveNotifier = ValueNotifier<bool>(_isActive);
    _isVerifiedNotifier = ValueNotifier<bool>(_isVerified);
    _pickedFileNotifier = ValueNotifier<File?>(_pickedFile);
    loadUsers(UserSearchObject(
        name: _searchController.text,
        PageSize: pageSize,
        PageNumber: currentPage));

    _searchController.addListener(() {
      final searchQuery = _searchController.text;
      loadUsers(UserSearchObject(name: searchQuery));
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _pickedFileNotifier.value = File(pickedFile.path);
      _pickedFile = File(pickedFile.path);
    }
  }

  Future<String> loadPhoto(String guidId) async {
    return await _photoProvider.getPhoto(guidId);
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

   void insertUser() async {
    try {
      Map<String, dynamic> userData = {
        'FirstName': _firstNameController.text,
        'LastName': _lastNameController.text,
        'Email': _emailController.text,
        'Password': _passwordController.text,
        'PhoneNumber': _phoneNumberController.text,
        'Address': '',
        'ProfessionalTitle': '',
        'Gender': selectedGender.toString(),
        'DateOfBirth':
            DateTime.parse(_birthDateController.text).toUtc().toIso8601String(),
        'Role': '0',
        'LastSignInAt': DateTime.now().toUtc().toIso8601String(),
        'IsVerified': _isVerified.toString(),
        'IsActive': _isActive.toString(),
      };
       if (_pickedFile == null) {
          final ByteData data =
            await rootBundle.load('assets/images/notFound.png');
        List<int> bytes = data.buffer.asUint8List();

        userData['ProfilePhoto'] = http.MultipartFile.fromBytes(
          'ProfilePhoto',
          bytes,
          filename: 'notFound.png',
        );
       } else {
          userData['ProfilePhoto'] = http.MultipartFile.fromBytes(
        'ProfilePhoto',
        _pickedFile!.readAsBytesSync(),
        filename: 'profile_photo.jpg',
      );
       }
      

      var response = await _userProvider.insertUser(userData);

      if (response == "OK") {
        Navigator.of(context).pop();
        loadUsers(
          UserSearchObject(
            name: _searchController.text,
            spol: null,
            isActive: null,
            isVerified: null,
            PageNumber: currentPage,
            PageSize: pageSize,
          ),
        );
        setState(() {
          selectedGender = null;
        });
      } else {
        showErrorDialog(context, 'Greška prilikom dodavanja');
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  void editUser(int id) async {
    try {
      Map<String, dynamic> userData = {
        "Id": id.toString(),
        'FirstName': _firstNameController.text,
        'LastName': _lastNameController.text,
        'Email': _emailController.text,
        'Password': _passwordController.text,
        'PhoneNumber': _phoneNumberController.text,
        'Address': '',
        'ProfessionalTitle': '',
        'Gender': selectedGender.toString(),
        'DateOfBirth':
            DateTime.parse(_birthDateController.text).toUtc().toIso8601String(),
        'Role': '0',
        'LastSignInAt': DateTime.now().toUtc().toIso8601String(),
        'IsVerified': _isVerified.toString(),
        'IsActive': _isActive.toString(),
      };
      if (_pickedFile != null) {
        userData['ProfilePhoto'] = http.MultipartFile.fromBytes(
          'ProfilePhoto',
          _pickedFile!.readAsBytesSync(),
          filename: 'profile_photo.jpg',
        );
       } 
       if (_pickedFile == null && selectedUsers[0].photo  == null) {
          final ByteData data =
            await rootBundle.load('assets/images/notFound.png');
        List<int> bytes = data.buffer.asUint8List();

        userData['ProfilePhoto'] = http.MultipartFile.fromBytes(
          'ProfilePhoto',
          bytes,
          filename: 'notFound.png',
        );
       } 
    
      var response = await _userProvider.updateUser(userData);

      if (response == "OK") {
        Navigator.of(context).pop();
        loadUsers(
          UserSearchObject(
            name: _searchController.text,
            spol: null,
            isActive: null,
            isVerified: null,
            PageNumber: currentPage,
            PageSize: pageSize,
          ),
        );
        setState(() {
          selectedGender = null;
        });
      } else {
        showErrorDialog(context, 'Greška prilikom uređivanja');
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
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
                    backgroundColor: dialogColor,
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
                          child:
                              Text("Zatvori", style: TextStyle(color: white))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              insertUser();
                            }
                          },
                          child: Text("Spremi", style: TextStyle(color: white)))
                    ],
                  );
                });
          },
          child: Row(
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
                      backgroundColor: dialogColor,
                      title: Text("Upozorenje"),
                      content: Text(
                          "Morate odabrati barem jednog klijenta za uređivanje"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK", style: TextStyle(color: white)),
                        ),
                      ],
                    );
                  });
            } else if (selectedUsers.length > 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: dialogColor,
                      title: Text("Upozorenje"),
                      content: Text(
                          "Odaberite samo jednog klijenta kojeg želite urediti"),
                      actions: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok", style: TextStyle(color: white)))
                      ],
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: dialogColor,
                      title: Text("Uredi klijenta"),
                      content: AddUserForm(
                          isEditing: true, userToEdit: selectedUsers[0]),
                      actions: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Zatvori",
                                style: TextStyle(color: white))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              editUser(selectedUsers[0].id);
                              selectedUsers = [];
                            },
                            child:
                                Text("Spremi", style: TextStyle(color: white))),
                      ],
                    );
                  });
            }
          },
          child: Row(
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
                            backgroundColor: dialogColor,
                            title: Text("Upozorenje"),
                            content: Text(
                                "Morate odabrati klijenta kojeg želite obrisati."),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child:
                                    Text("OK", style: TextStyle(color: white)),
                              ),
                            ]);
                      });
                }
              : () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: dialogColor,
                          title: Text("Izbriši klijenta!"),
                          content: SingleChildScrollView(
                            child: Text(
                                "Da li ste sigurni da želite obrisati klijenta?"),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Odustani",
                                  style: TextStyle(color: white)),
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
                              child: Text("Obriši",
                                  style: TextStyle(color: white)),
                            ),
                          ],
                        );
                      });
                },
          child: Row(
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
                              DataCell(
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FutureBuilder<String>(
                                        future: loadPhoto(
                                            userItem.photo?.guidId ?? ''),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text('--');
                                          } else {
                                            final imageUrl = snapshot.data;

                                            if (imageUrl != null &&
                                                imageUrl.isNotEmpty) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: FadeInImage(
                                                  image: NetworkImage(
                                                    imageUrl,
                                                    headers: Authorization
                                                        .createHeaders(),
                                                  ),
                                                  placeholder: MemoryImage(
                                                      kTransparentImage),
                                                  fadeInDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  fit: BoxFit.fill,
                                                  width: 80,
                                                  height: 105,
                                                ),
                                              );
                                            } else {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Image.asset(
                                                  'assets/images/notFound.png',
                                                  width: 80,
                                                  height: 105,
                                                  fit: BoxFit.fill,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                        color: green,
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
                                        color: green,
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
                  ValueListenableBuilder<File?>(
                      valueListenable: _pickedFileNotifier,
                      builder: (context, pickedFile, _) {
                        return Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 180,
                          color: primaryColor,
                          child: FutureBuilder<String>(
                            future: _pickedFile != null
                                ? Future.value(_pickedFile!.path)
                                : loadPhoto(isEditing
                                    ? (userToEdit?.photo?.guidId ?? '')
                                    : ''),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Molimo odaberite fotografiju');
                              } else {
                                final imageUrl = snapshot.data;

                                if (imageUrl != null && imageUrl.isNotEmpty) {
                                  return Container(
                                    child: FadeInImage(
                                      image: _pickedFile != null
                                          ? FileImage(_pickedFile!)
                                              as ImageProvider<Object>
                                          : NetworkImage(
                                              imageUrl,
                                              headers:
                                                  Authorization.createHeaders(),
                                            ) as ImageProvider<Object>,
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      fadeInDuration:
                                          const Duration(milliseconds: 300),
                                      fit: BoxFit.cover,
                                      width: 230,
                                      height: 200,
                                    ),
                                  );
                                } else {
                                  return isEditing
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: const Text(
                                              'Please select an image'),
                                        )
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Image.asset(
                                            'assets/images/default_user_image.jpg',
                                            width: 230,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                }
                              }
                            },
                          ),
                        );
                      }),
                  const SizedBox(height: 35),
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () => _pickImage(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text('Select An Image',
                            style: TextStyle(fontSize: 12, color: white)),
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
                    decoration: InputDecoration(labelText: 'Šifra'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite šifru!';
                      }

                      // Check for at least 8 characters
                      if (value.length < 8) {
                        return 'Šifra mora sadržavati barem 8 karaktera!';
                      }

                      // Check for at least one uppercase letter
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Šifra mora sadržavati barem jedno veliko slovo!';
                      }

                      // Check for at least one lowercase letter
                      if (!value.contains(RegExp(r'[a-z]'))) {
                        return 'Šifra mora sadržavati barem jedno malo slovo!';
                      }

                      // Check for at least one digit
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Šifra mora sadržavati barem jedan broj!';
                      }

                      // Check for at least one special character
                      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Šifra mora sadržavati barem jedan specijalni karakter!';
                      }

                      return null;
                    },
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
                      hintText: 'Odaberite datum',
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
                  ValueListenableBuilder<bool>(
                    valueListenable: _isActiveNotifier,
                    builder: (context, isActive, child) {
                      return Row(
                        children: [
                          Checkbox(
                            value: _isActiveNotifier.value,
                            onChanged: (bool? value) {
                              _isActiveNotifier.value =
                                  !_isActiveNotifier.value;
                              _isActive = _isActiveNotifier.value;
                            },
                          ),
                          Text('Aktivan'),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isVerifiedNotifier,
                    builder: (context, isVerified, child) {
                      return Row(
                        children: [
                          Checkbox(
                            value: _isVerifiedNotifier.value,
                            onChanged: (bool? value) {
                              _isVerifiedNotifier.value =
                                  !_isVerifiedNotifier.value;
                              _isVerified = _isVerifiedNotifier.value;
                            },
                          ),
                          Text('Verifikovan'),
                        ],
                      );
                    },
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed: () {
            if (currentPage > 1) {
              setState(() {
                currentPage--;
              });
              loadUsers(
                UserSearchObject(
                  PageNumber: currentPage,
                  PageSize: pageSize,
                ),
              );
            }
          },
          child: const Icon(
            Icons.arrow_left_outlined,
            color: white,
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed: () {
            setState(() {
              if (hasNextPage == pageSize) {
                currentPage++;
              }
            });
            if (hasNextPage == pageSize) {
              loadUsers(
                UserSearchObject(
                    PageNumber: currentPage,
                    PageSize: pageSize,
                    name: _searchController.text),
              );
            }
          },
          child: const Icon(
            Icons.arrow_right_outlined,
            color: white,
          ),
        ),
      ],
    );
  }
}
