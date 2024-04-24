import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/user.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/photo_provider.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:gymfit_mobile/utils/authorization.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

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
  ValueNotifier<File?> _pickedFileNotifier = ValueNotifier(null);

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
  File? _pickedFile;

  File? selectedImage;
  late PhotoProvider _photoProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mediaQueryData = MediaQuery.of(context);
  }

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _loginProvider = context.read<UserLoginProvider>();

    _photoProvider = context.read<PhotoProvider>();
    _pickedFileNotifier = ValueNotifier<File?>(_pickedFile);
    loadUser();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _pickedFile = File(pickedFile.path);
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
        'DateOfBirth': DateTime.parse(_birthDateController.text)
            .add(const Duration(days: 1))
            .toUtc()
            .toIso8601String(),
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
      if (_pickedFile == null && user!.photo  == null) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Color(0XFF12B422),
              content: Text('Uspješno uređen profil.',
                  style: TextStyle(
                    color: Colors.white,
                  ))),
        );
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
      if (user == "OK") {}
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  Future<String> loadPhoto(String guidId) async {
    return await _photoProvider.getPhoto(guidId);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    if (user == null) {
      return _buildLoadingIndicator();
    }

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

  Widget _buildLoadingIndicator() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: appTheme.bgSecondary,
          body: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: appTheme.bgSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: 90,
                    height: 120,
                    color: primary,
                    child: FutureBuilder<String>(
                      future: user?.photo?.guidId != null
                          ? loadPhoto(user!.photo!.guidId!)
                          : null, // Check if user?.photo is not null before calling loadPhoto
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        final imageUrl = snapshot.data;

                        return FadeInImage(
                          image: imageUrl != null && imageUrl.isNotEmpty
                              ? NetworkImage(
                                  imageUrl,
                                  headers: Authorization.createHeaders(),
                                )
                              : AssetImage('assets/images/notFound.png')
                                  as ImageProvider<Object>,
                          placeholder: MemoryImage(kTransparentImage),
                          fadeInDuration: const Duration(milliseconds: 100),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
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
          _buildUserData("Spol: ", user?.gender == 0 ? "Muski" : "Zenski"),
          _buildEditUserButton(),
          ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: teal),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.changePassword);
                    },
                    child: Text(
                      "Promjeni lozinku",
                      style: TextStyle(color: white),
                    )),
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
        padding: EdgeInsets.symmetric(horizontal: 15),
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
              ),
              content: AddUserForm(isEditing: true, userToEdit: user),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Zatvori",
                    style: TextStyle(fontSize: 12, color: white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (_formKey.currentState!.validate()) {
                      editUser(user!.id);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "Spremi",
                      style: TextStyle(color: white, fontSize: 12),
                    ),
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
      ),
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
            Column(children: [
              ValueListenableBuilder<File?>(
                valueListenable: _pickedFileNotifier,
                builder: (context, pickedFile, _) {
                  return Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 180,
                    color: primary,
                    child: FutureBuilder<String>(
                      future: userToEdit?.photo?.guidId != null
                          ? loadPhoto(userToEdit!.photo!.guidId!)
                          : null,
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
                                        headers: Authorization.createHeaders(),
                                      ) as ImageProvider<Object>,
                                placeholder: MemoryImage(kTransparentImage),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: const Text('Please select an image'),
                                  )
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: const Text(
                                        'Molimo odaberite fotografiju'),
                                  );
                          }
                        }
                      },
                    ),
                  );
                },
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
                        style: TextStyle(fontSize: 12, color: white)),
                  ),
                ),
              )
            ]),
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
