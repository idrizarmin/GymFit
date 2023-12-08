import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/user.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<User> users = <User>[];
  List<User> selectedUsers = <User>[];
  late MediaQueryData mediaQueryData;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final int userId = 0;
  User? user;
  DateTime selectedDate = DateTime.now();
  late UserProvider _userProvider;
  late UserLoginProvider _loginProvider;
  bool isEditing = false;
  int? selectedGender;
  int? selectedRole;
  bool _isActive = false;
  bool _isVerified = false;
  File? _image;
  XFile? _pickedFile;
  final _picker = ImagePicker();
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _loginProvider = context.read<UserLoginProvider>();
    loadUser();
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

  void loadUser() async {
    var id = _loginProvider.getUserId();
    print(id);
    try {
      var usersResponse = await _userProvider.getById(id!);
      setState(() {
        user = usersResponse;
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
        "dateOfBirth": _birthDateController.text,
        "phoneNumber": _phoneNumberController.text,
        "gender": selectedGender,
        "isActive": _isActive,
        "role": selectedRole,
        "isVerified": _isVerified,
        "password": _passwordController.text,
        "profilePhoto": imageBase64
      };
      var user = await _userProvider.edit(newUser);
      if (user == "OK") {
        Navigator.of(context).pop();
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
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
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.bgSecondary,
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 1,
                  ),
                  decoration: AppDecoration.fillBlack,
                  child: Text(
                    "Korisnički profil",
                    style: TextStyle(fontSize: 14, color: white),
                  ),
                ),
                _buildUserProfile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath:
                    "assets/images/notFound.png", // Replace with the actual image path
                width: 100,
                height: 100,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserData("", user?.firstName ?? "--"),
                  _buildUserData("", user?.lastName ?? "--"),
                  _buildUserData("Email: ", user?.email ?? "--"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildUserData("Broj telefona: ", user?.phoneNumber ?? "--"),
          _buildUserData(
              "Datum rođenja: ",
              user?.dateOfBirth == null
                  ? "--"
                  : DateFormat('dd.MM.yyyy')
                      .format(DateTime.parse(user!.dateOfBirth!))
                      .toString()),
          _buildUserData("Spol: ", user?.gender == 0 ? "Muski" : "Zesnki"),
          _buildEditUserButton(),
        ],
      ),
    );
  }

  Widget _buildUserData(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  ElevatedButton _buildEditUserButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: teal,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: appTheme.bgSecondary,
              title: Text(
                "Uredi podatke",
                style: TextStyle(color: white, fontSize: 18),
              ), // Adjust font size
              content: AddUserForm(isEditing: true, userToEdit: user),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10), // Adjust padding for button size
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Zatvori",
                    style: TextStyle(fontSize: 12, color: white),
                  ), // Adjust font size
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10), // Adjust padding for button size
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      EditUser(user!.id);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "Spremi",
                      style: TextStyle(color: white, fontSize: 12),
                    ), // Adjust font size
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Text(
        "Uredi profil",
        style: TextStyle(fontSize: 14, color: white),
      ), // Adjust font size
    );
  }

  

  Widget AddUserForm({bool isEditing = false, User? userToEdit}) {
    if (userToEdit != null) {
      _firstNameController.text = userToEdit.firstName;
      _lastNameController.text = userToEdit.lastName;
      _emailController.text = userToEdit.email;
      _phoneNumberController.text = userToEdit.phoneNumber ?? '';
      _birthDateController.text = userToEdit.dateOfBirth ?? '';
      selectedRole = userToEdit.role;
      selectedGender = userToEdit.gender;
      _isActive = userToEdit.isActive;
      _isVerified = userToEdit.isVerified;
      _passwordController.text = '';
      _pickedFile = null;
    }

    return Container(
      height: 450,
      width: mediaQueryData.devicePixelRatio,
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              height: 150,
              width: 150,
              color: teal,
              child: Center(
                child: (_pickedFile != null)
                    ? Image.file(
                        File(_pickedFile!.path),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : (userToEdit != null && userToEdit.profilePhoto != null)
                        ? Image.memory(
                            Uint8List.fromList(
                                base64Decode(userToEdit.profilePhoto!.data)),
                            width: 230,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : const Text('Please select an image'),
              ),
            ),
            const SizedBox(height: 35),
            Center(
              child: SizedBox(
                width: 150,
                height: 35,
                child: ElevatedButton(
                  onPressed: () => _pickImage(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text('Select An Image',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Ime',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite ime!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Prezime',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite prezime!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
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
                    decoration: const InputDecoration(
                      labelText: 'Broj',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextFormField(
                    controller: _birthDateController,
                    decoration: const InputDecoration(
                      labelText: 'Datum rođenja',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
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
                    items: const [
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
                    decoration: const InputDecoration(
                      labelText: 'Spol',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Unesite spol!';
                      }
                      return null;
                    },
                    dropdownColor: teal,
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
