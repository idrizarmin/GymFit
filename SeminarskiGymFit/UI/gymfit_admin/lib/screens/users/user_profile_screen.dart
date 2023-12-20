import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/user.dart';
import 'package:gymfit_admin/providers/login_provider.dart';
import 'package:gymfit_admin/providers/photo_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:gymfit_admin/utils/authorization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<User> users = <User>[];
  List<User> selectedUsers = <User>[];
  late UserProvider _userProvider;
  late LoginProvider _loginProvider;
  late PhotoProvider _photoProvider;
  bool isEditing = false;
  User? admin;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ValueNotifier<File?> _pickedFileNotifier = ValueNotifier(null);
  final int userId = 0;
  DateTime selectedDate = DateTime.now();
  int? selectedGender;
  int? selectedCinemaId;
  int? selectedRole;
  bool _isActive = false;
  bool _isVerified = false;
  bool isAllSelected = false;
  int currentPage = 1;
  int pageSize = 20;

  File? _pickedFile;
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _loginProvider = context.read<LoginProvider>();
    _photoProvider = context.read<PhotoProvider>();
    _pickedFileNotifier = ValueNotifier<File?>(_pickedFile);

    loadAdmin();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _pickedFileNotifier.value = File(pickedFile.path);
      _pickedFile = File(pickedFile.path);
    }
  }

  void loadAdmin() async {
    var id = _loginProvider.getUserId();
    try {
      var usersResponse = await _userProvider.getById(id!);
      setState(() {
        admin = usersResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  Future<String> loadPhoto(String guidId) async {
    return await _photoProvider.getPhoto(guidId);
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
        'Role': '1',
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
      // Send the request
      var response = await _userProvider.updateUser(userData);

      if (response == "OK") {
        Navigator.of(context).pop();
      } else {
        // Handle error
        showErrorDialog(context, 'Greška prilikom uređivanja');
      }
    } catch (e) {
      // Handle exceptions
      showErrorDialog(context, e.toString());
    }
  }

  void DeleteUser(int id) async {
    try {
      var user = await _userProvider.delete(id);
      if (user == "OK") {}
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (admin == null) {
      return CircularProgressIndicator();
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  child: const Header(pageTitle: "Korisnički račun"),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: FutureBuilder<String>(
                            future: loadPhoto(admin!.photo?.guidId ?? ''),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Greška prilikom učitavanja slike');
                              } else {
                                final imageUrl = snapshot.data;

                                if (imageUrl != null && imageUrl.isNotEmpty) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: ClipOval(
                                      child: FadeInImage(
                                        image: NetworkImage(
                                          imageUrl,
                                          headers: Authorization.createHeaders(),
                                        ),
                                        placeholder: MemoryImage(kTransparentImage),
                                        fadeInDuration: const Duration(milliseconds: 300),
                                        fit: BoxFit.cover,
                                        width: 200, // Adjust the width as needed
                                        height: 200, // Adjust the height as needed
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/user1.jpg',
                                        width: 120, // Adjust the width as needed
                                        height: 120, // Adjust the height as needed
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          transformAlignment: Alignment.center,
                          width: 500,
                          child: Column(
                            children: [
                              _buildUserData("Ime: ", admin?.firstName ?? "--"),
                              _buildUserData("Prezime : ", admin?.lastName ?? "--"),
                              _buildUserData("Email: ", admin?.email ?? "--"),
                              _buildUserData("Broj telefona: ", admin?.phoneNumber ?? "--"),
                              _buildUserData(
                                "Datum rođenja: ",
                                admin?.dateOfBirth == null
                                    ? "--"
                                    : DateFormat('dd/MM/yyyy')
                                    .format(
                                      DateTime.parse(admin!.dateOfBirth!))
                                    .toString(),
                              ),
                              _buildUserData("Spol: ", admin?.gender == 0 ? "Muski" : "Zenski" ?? "--"),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {},
                          child: Text("Promjena lozinke", style: TextStyle(color: white)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                                  title: Text("Uredi klijenta"),
                                  content: AddUserForm(
                                    isEditing: true, userToEdit: admin),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Zatvori", style: TextStyle(color: white))),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
                                      onPressed: () {
                                        editUser(selectedUsers[0].id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Spremi", style: TextStyle(color: white))),
                                  ],
                                );
                              });
                          },
                          child: Text("Uredi profil", style: TextStyle(color: white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildUserData(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

 Widget AddUserForm({bool isEditing = false, User? userToEdit}) {
    if (userToEdit != null) {
      _firstNameController.text = userToEdit.firstName;
      _lastNameController.text = userToEdit.lastName;
      _emailController.text = userToEdit.email;
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
                                  // Ako uređujete korisnika, pokažite poruku za odabir slike
                                  // Inače, prikažite podrazumevanu sliku iz assetsa
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
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
