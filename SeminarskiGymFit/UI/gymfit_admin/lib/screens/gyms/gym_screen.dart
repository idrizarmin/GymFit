import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/gym.dart';
import 'package:gymfit_admin/models/post.dart';
import 'package:gymfit_admin/providers/gym_provider.dart';
import 'package:gymfit_admin/providers/post_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class GymScreen extends StatefulWidget {
  const GymScreen({Key? key}) : super(key: key);

  @override
  State<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addresController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  List<Post> selectedPosts = <Post>[];
  List<Post> posts = <Post>[];
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();
  late GymProvider _gymProvider;
  late PostProvider _postProvider;
  bool isAllSelected = false;
  List<Gym?> gyms = <Gym>[];
  XFile? _pickedFile;
  File? _image;
  final _picker = ImagePicker();
  File? selectedImage;
  int currentPage = 1;
  int pageSize = 20;
  int hasNextPage = 0;

  @override
  void initState() {
    super.initState();
    _gymProvider = GymProvider();
    _postProvider = PostProvider();
    loadGyms();
    loadPosts();
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

  void loadGyms() async {
    try {
      var gymResponse = await _gymProvider.getPaged();
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
        "id": id,
        "name": _nameController.text,
        "address": false,
        "description": false,
        "phoneNumber": null,
        "website": null,
      };
      var change = await _gymProvider.edit(newGym);
      if (change == "OK") {
        loadGyms();
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadPosts() async {
    try {
      var response = await _postProvider.getPaged();
      if (mounted) {
        setState(() {
          posts = response;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void EditPost(int id) async {
    try {
      var imageFile = File(_image!.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String imageBase64 = base64Encode(imageBytes);

      var post = {
        "id": id,
        "title": _titleController,
        "content": _contentController.text,
        "publishDate": DateTime.now().toUtc().toIso8601String(),
        "photo": imageBase64,
      };
      var change = await _postProvider.edit(post);
      if (change == "OK") {
        currentPage = 1;
        loadPosts();
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void DeletePost(int id) async {
    try {
      var post = await _postProvider.delete(id);
      if (post == "OK") {
        currentPage = 1;
        loadPosts();
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void InsertPost() async {
    try {
      var imageFile = File(_image!.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String imageBase64 = base64Encode(imageBytes);
      var newPost = {
        "id": 0,
        "title": _titleController.text,
        "content": _contentController.text,
        "status": 1,
        "publishDate": DateTime.now().toUtc().toIso8601String(),
        "photo": imageBase64,
      };
      var post = await _postProvider.insert(newPost);
      if (post == "OK") {
        Navigator.of(context).pop();
        loadPosts();
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
          buildGymInfo(context),
          PrimaryText(
            text: "Objave",
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 10,
          ),
          buildButtonsForPosts(context),
          SizedBox(
            height: 16,
          ),
          buildDataView(context)
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
                        title: Text("Izmjeni podatke teretane"),
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
                                  EditGym(gyms[0]!.id);
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

  Row buildButtonsForPosts(BuildContext context) {
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
                  title: Text("Kreiraj objavu"),
                  content: SingleChildScrollView(child: AddPostForm()),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: myButtonColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Zatvori"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myButtonColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        InsertPost();
                      },
                      child: Text("Spremi"),
                    ),
                  ],
                );
              },
            );
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
            if (selectedPosts.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content:
                          Text("Morate odabrati jednu objavu za  uređivanje"),
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
            } else if (selectedPosts.length > 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content: Text(
                          "Odaberite samo jednu objavu koju želite urediti"),
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
                      title: Text("Uredi objavu"),
                      content: AddPostForm(
                          isEditing: true, postToEdit: selectedPosts[0]),
                      actions: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              //loadUsers();
                              Navigator.of(context).pop();
                            },
                            child: Text("Zatvori")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              EditPost(selectedPosts[0].id);
                              Navigator.of(context).pop();
                              selectedPosts = [];
                              //loadUsers();
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
          onPressed: selectedPosts.isEmpty
              ? () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Upozorenje"),
                            content: Text(
                                "Morate odabrati objavu koju želite obrisati."),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
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
                        title: Text("Izbriši objavu!"),
                        content: SingleChildScrollView(
                          child: Text(
                              "Da li ste sigurni da želite obrisati objavu?"),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
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
                              for (Post n in selectedPosts) {
                                DeletePost(n.id);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text("Obriši"),
                          ),
                        ],
                      );
                    },
                  );
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
        const SizedBox(width: 16.0),
      ],
    );
  }

  Expanded buildDataView(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.white, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DataTable(
                dataRowColor: MaterialStateProperty.all(
                    const Color.fromARGB(42, 241, 241, 241)),
                columns: [
                  DataColumn(
                      label: Checkbox(
                          value: isAllSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              isAllSelected = value ?? false;
                              posts.forEach((notificationItem) {
                                notificationItem.isSelected = isAllSelected;
                              });

                              if (!isAllSelected) {
                                selectedPosts.clear();
                              } else {
                                selectedPosts = List.from(posts);
                              }
                            });
                          })),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Naslov",
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Sadržaj",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Datum kreiranja",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      child: Text(
                        "Slika",
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ],
                rows: posts.map((postItem) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Checkbox(
                          value: postItem.isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              postItem.isSelected = value ?? false;
                              if (postItem.isSelected == true) {
                                selectedPosts.add(postItem);
                              } else {
                                selectedPosts.remove(postItem);
                              }
                              isAllSelected = posts.every(
                                  (notification) => notification.isSelected);
                            });
                          },
                        ),
                      ),
                      DataCell(Text(postItem.title!)),
                      DataCell(Text(postItem.content!)),
                      DataCell(
                        Text(
                          postItem.publishDate != null
                              ? DateFormat('dd.MM.yyyy')
                                  .format(postItem.publishDate!)
                              : '--',
                        ),
                      ),
                      DataCell(Row(
                        children: [
                          if (postItem.photo != null)
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Image.memory(
                                Uint8List.fromList(
                                    base64Decode(postItem.photo!.data)),
                                width: 40,
                                height: 40,
                              ),
                            )
                          else
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Image.asset('assets/images/user1.jpg',
                                  width: 70, height: 100),
                            ),
                        ],
                      )),
                    ],
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }

  Widget AddPostForm({bool isEditing = false, Post? postToEdit}) {
    if (postToEdit != null) {
      _contentController.text = postToEdit.content!;
      _titleController.text = postToEdit.title!;
      _pickedFile = null;
    } else {
      _contentController.text = '';
      _titleController.text = '';
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
                padding: const EdgeInsets.all(35),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 280,
                    color: Color.fromARGB(255, 94, 229, 143),
                    child: (_pickedFile != null)
                        ? Image.file(
                            File(_pickedFile!.path),
                            width: 230,
                            height: 250,
                            fit: BoxFit.cover,
                          )
                        : (postToEdit != null && postToEdit.photo != null)
                            ? Image.memory(
                                Uint8List.fromList(
                                    base64Decode(postToEdit.photo!.data)),
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
                          primary: Colors.teal, // Boja pozadine
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Zaobljenost rubova
                          ),
                        ),
                        child: Text('Odaberi sliku',
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
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Naslov'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Unesite naslov!';
                      }
                      return null;
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _contentController,
                      maxLines:
                          null, // Postavljanje na null omogućuje unos većeg teksta
                      keyboardType: TextInputType
                          .multiline, // Omogućuje više redova teksta
                      decoration: InputDecoration(labelText: 'Sadržaj'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Unesite sadržaj!';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGymInfo(BuildContext context) {
    return SingleChildScrollView(
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
            dataRowColor: MaterialStateProperty.all(
                const Color.fromARGB(42, 241, 241, 241)),
            columns: const [
              DataColumn(
                label: Expanded(
                  child: Text(
                    "Naziv",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Opis",
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
              DataColumn(
                label: Text(
                  "Adresa",
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
              DataColumn(
                label: Text(
                  "Broj telefona",
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
              DataColumn(
                label: Text(
                  "Website",
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ],
            rows: gyms.map((gymItem) {
              return DataRow(
                cells: [
                  DataCell(Text(gymItem?.name ?? '')),
                  DataCell(Text(gymItem?.description ?? '')),
                  DataCell(Text(gymItem?.address ?? '')),
                  DataCell(Text(gymItem?.phoneNumber ?? '')),
                  DataCell(Text(gymItem?.website ?? '')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
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
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Naziv teretane'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Obavezan unos!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Opis teretane'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Obavezan unos!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _addresController,
                      decoration: InputDecoration(labelText: 'Adresa'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Obavezan unos!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(labelText: 'Broj telefona'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Obavezan unos!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _websiteController,
                      decoration: InputDecoration(labelText: 'Website'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Obavezan unos!';
                        }
                        return null;
                      },
                    ),
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
