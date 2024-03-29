import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/gym.dart';
import 'package:gymfit_admin/models/post.dart';
import 'package:gymfit_admin/providers/gym_provider.dart';
import 'package:gymfit_admin/providers/post_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
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
  Gym? gym;
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

  void loadGyms() async {
    try {
      var gymResponse = await _gymProvider.getById(2);
      if (mounted) {
        setState(() {
          gym = gymResponse;
          print(gym!.description!);
          gyms.add(gym);
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void EditGym(int id) async {
    try {
      var newGym = {
        "id": 2,
        "name": _nameController.text,
        "address": _addresController.text,
        "description": _descriptionController.text,
        "phoneNumber": _phoneNumberController.text,
        "website": _websiteController.text,
        "createdAt": null,
        "modifiedAt": null,
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
      var post = {
        "id": id,
        "title": _titleController.text,
        "content": _contentController.text,
        "publishDate": DateTime.now().toUtc().toIso8601String(),
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
      var newPost = {
        "id": 0,
        "title": _titleController.text,
        "content": _contentController.text,
        "status": 1,
        "publishDate": DateTime.now().toUtc().toIso8601String(),
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
    if (gym == null) {
      return _buildLoadingIndicator();
    }

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
          buildGymInfo(context, gym!),
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

  Widget _buildLoadingIndicator() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: bgColor,
          body: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: bgColor,
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
                        backgroundColor: dialogColor,
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
                              child: Text("Zatvori",
                                  style: TextStyle(color: white))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  EditGym(gyms[0]!.id);
                                  Navigator.of(context).pop();
                                  loadGyms();
                                }
                              },
                              child: Text("Spremi",
                                  style: TextStyle(color: white)))
                        ],
                      );
                    });
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
              onPressed: () {
                loadGyms();
              },
              child: Row(
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
                  backgroundColor: dialogColor,
                  title: Text("Kreiraj objavu"),
                  content: SingleChildScrollView(child: AddPostForm()),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Zatvori", style: TextStyle(color: white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          InsertPost();
                        }
                      },
                      child: Text("Spremi", style: TextStyle(color: white)),
                    ),
                  ],
                );
              },
            );
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
            if (selectedPosts.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: dialogColor,
                      title: Text("Upozorenje"),
                      content:
                          Text("Morate odabrati jednu objavu za  uređivanje"),
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
            } else if (selectedPosts.length > 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: dialogColor,
                      title: Text("Upozorenje"),
                      content: Text(
                          "Odaberite samo jednu objavu koju želite urediti"),
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
                      title: Text("Uredi objavu"),
                      content: AddPostForm(
                          isEditing: true, postToEdit: selectedPosts[0]),
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
                              if (_formKey.currentState!.validate()) {
                                EditPost(selectedPosts[0].id);
                                Navigator.of(context).pop();
                                selectedPosts = [];
                              }
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
          onPressed: selectedPosts.isEmpty
              ? () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            backgroundColor: dialogColor,
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
                            child: Text("Odustani",
                                style: TextStyle(color: white)),
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
                            child:
                                Text("Obriši", style: TextStyle(color: white)),
                          ),
                        ],
                      );
                    },
                  );
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
                              posts.forEach((postItem) {
                                postItem.isSelected = isAllSelected;
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
    } else {
      _contentController.text = '';
      _titleController.text = '';
    }
    return Container(
      height: 450,
      width: 950,
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
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
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

  Widget buildGymInfo(BuildContext context, Gym gym) {
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
            rows: [
              DataRow(
                cells: [
                  DataCell(Text(gym.name ?? '')),
                  DataCell(Text(gym.description ?? '')),
                  DataCell(Text(gym.address ?? '')),
                  DataCell(Text(gym.phoneNumber ?? '')),
                  DataCell(Text(gym.website ?? '')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget EditGymForm({
    bool isEditing = true,
    Gym? gymToEdit,
  }) {
    if (gymToEdit != null) {
      _nameController.text = gymToEdit.name;
      _descriptionController.text = gymToEdit.description ?? " ";
      _addresController.text = gymToEdit.address ?? "";
      _websiteController.text = gymToEdit.website ?? "";
      _phoneNumberController.text = gymToEdit.phoneNumber ?? "";
    }

    return Container(
      height: 450,
      width: 950,
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
