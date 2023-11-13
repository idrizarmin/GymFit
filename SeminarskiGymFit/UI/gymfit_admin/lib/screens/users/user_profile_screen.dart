import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/searchObjects/user_search.dart';
import 'package:gymfit_admin/models/user.dart';
import 'package:gymfit_admin/providers/login_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  bool isEditing = false;
  User? admin;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final int userId = 0;
  DateTime selectedDate = DateTime.now();

  String _selectedIsActive = 'Svi';
  String _selectedIsVerified = 'Svi';
  int? selectedGender;
  int? selectedCinemaId;
  int? selectedRole;
  bool _isActive = false;
  bool _isVerified = false;
  bool isAllSelected = false;
  int currentPage = 1;

  File? _image;
  XFile? _pickedFile;
  final _picker = ImagePicker();
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _loginProvider = context.read<LoginProvider>();
    loadAdmin();
    loadUsers(
        UserSearchObject(
          name: _searchController.text,
        ),
        _selectedIsActive,
        _selectedIsVerified);

    _searchController.addListener(() {
      final searchQuery = _searchController.text;
      loadUsers(UserSearchObject(name: searchQuery), _selectedIsActive,
          _selectedIsVerified);
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

  void loadUsers(UserSearchObject searchObject, String selectedIsActive,
      String selectedIsVerified) async {
    searchObject.isActive = selectedIsActive == 'Aktivni'
        ? true
        : selectedIsActive == 'Neaktivni'
            ? false
            : null;

    searchObject.isVerified = selectedIsVerified == 'Verifikovani'
        ? true
        : selectedIsVerified == 'Neverifikovani'
            ? false
            : null;
    try {
      var usersResponse =
          await _userProvider.getPaged(searchObject: searchObject);
      setState(() {
        users = usersResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
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
        "birthDate": _birthDateController.text,
        "phoneNumber": _phoneNumberController.text,
        "gender": selectedGender,
        "isActive": _isActive,
        "role": selectedRole,
        "isVerified": _isVerified,
        "password": _passwordController.text,
      };
      var user = await _userProvider.edit(newUser);
      if (user == "OK") {
        Navigator.of(context).pop();
        loadUsers(UserSearchObject(name: _searchController.text),
            _selectedIsActive, _selectedIsVerified);
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void DeleteUser(int id) async {
    try {
      var user = await _userProvider.delete(id);
      if (user == "OK") {
        //Navigator.of(context).pop();
        loadUsers(UserSearchObject(name: _searchController.text),
            _selectedIsActive, _selectedIsVerified);
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
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
                child: const Heder(pageTitle: "Korisnički račun")),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Container(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                AssetImage('assets/images/user1.jpg'),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
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
                          _buildUserData(
                              "Broj telefona: ", admin?.phoneNumber ?? "--"),
                          _buildUserData(
                              "Datum rođenja: ",
                              admin?.birthDate == null
                                  ? "--"
                                  : DateFormat('dd/MM/yyyy')
                                      .format(DateTime.parse(admin!.birthDate!))
                                      .toString()),
                          _buildUserData("Spol: ",
                              admin?.gender == 0 ? "Muski" : "Zesnki" ?? "--"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {},
                        child: Text("Promjena lozinke")),
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
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Spremi")),
                                  ],
                                );
                              });
                        },
                        child: Text("Uredi profil")),
                  ],
                ),
              ),
            ),
          ])),
    ));
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
      _firstNameController.text = userToEdit.firstName ?? '';
      _lastNameController.text = userToEdit.lastName ?? '';
      _emailController.text = userToEdit.email ?? '';
      _phoneNumberController.text = userToEdit.phoneNumber ?? '';
      _birthDateController.text = userToEdit.birthDate ?? '';
      selectedRole = userToEdit.role;
      selectedGender = userToEdit.gender;
      _isActive = userToEdit.isActive;
      _isVerified = userToEdit.isVerified;
      _passwordController.text = '';
      _pickedFile = null;
    }

    return Container(
      height: 450,
      width: 950,
      color: secondaryColor,
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
                child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,5,20,10),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 350,
                    color: Colors.grey[300],
                     child: Image.asset('assets/images/user1.jpg')
                    //(_pickedFile != null)
                    //     ? Image.file(
                    //   File(_pickedFile!.path),
                    //   width: 230,
                    //   height: 200,
                    //   fit: BoxFit.cover,
                    // )
                    //     : (userToEdit != null && userToEdit.profilePhoto != null)
                    //     ? Image.memory(
                    //   Uint8List.fromList(
                    //       base64Decode(userToEdit.profilePhoto!.data)),
                    //   width: 230,
                    //   height: 200,
                    //   fit: BoxFit.cover,
                    // )
                    //     : const Text('Please select an image'),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: SizedBox(
                      width: 150, // Širina dugmeta
                      height: 35, // Visina dugmeta
                      child: ElevatedButton(
                        onPressed: () => _pickImage(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal, // Boja pozadine
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Zaobljenost rubova
                          ),
                        ),
                        child: Text('Select An Image',
                            style: TextStyle(fontSize: 14)),
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
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            
          ],
        ),
      ),
    );
  }
}
