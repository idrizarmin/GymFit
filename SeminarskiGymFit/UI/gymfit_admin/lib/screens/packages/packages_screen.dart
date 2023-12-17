import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/package.dart';
import 'package:gymfit_admin/models/searchObjects/package_search.dart';
import 'package:gymfit_admin/providers/package_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  List<Package> packages = <Package>[];
  List<Package> selectedpackages = <Package>[];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  late PackageProvider _packageProvider;
  bool isEditing = false;
  bool isAllSelected = false;
  int currentPage = 1;
  int pageSize = 10;
  int hasNextPage = 0;

  @override
  void initState() {
    super.initState();
    _packageProvider = PackageProvider();

    loadPackages();
  }

  void loadPackages() async {
    try {
      PackageSearchObject searchObject =
          PackageSearchObject(PageNumber: currentPage, PageSize: pageSize);

      var Response =
          await _packageProvider.getPaged(searchObject: searchObject);
      setState(() {
        packages = Response;
        hasNextPage = packages.length;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void InsertPackage() async {
    try {
      var newPackage = {
        "id": 0,
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": double.parse(_priceController.text)
      };
      var notification = await _packageProvider.insert(newPackage);
      if (notification == "OK") {
        currentPage == 1;
        loadPackages();
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void EditPackage(int id) async {
    try {
      var newPackage = {
        "id": id,
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": double.parse(_priceController.text)
      };
      var change = await _packageProvider.edit(newPackage);
      if (change == "OK") {
        currentPage = 1;
        loadPackages();
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void DeletePackage(int id) async {
    try {
      var actor = await _packageProvider.delete(id);
      if (actor == "OK") {
        currentPage = 1;
        loadPackages();
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
            child: const Header(pageTitle: "Paketi"),
          ),
          const SizedBox(
            height: 16,
          ),
          buildButtons(context),
          SizedBox(
            height: 16,
          ),
          buildDataView(context),
          SizedBox(
            height: 1,
          ),
          _buildPagination(),
        ]),
      ),
    );
  }

  Row _buildPagination() {
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
              loadPackages();
            }
          },
          child: const Icon(Icons.arrow_left_outlined, color: white,),
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
              loadPackages();
            }
          },
          child: const Icon(Icons.arrow_right_outlined ,color: white,),
        ),
      ],
    );
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
                  // backgroundColor: secondaryColor,
                  title: Text("Kreiraj paket"),
                  content: SingleChildScrollView(child: AddPackageForm()),
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
                        if (_formKey.currentState!.validate()) {
                            InsertPackage();
                            Navigator.of(context).pop();
                        }
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
            if (selectedpackages.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content:
                          Text("Morate odabrati jedan paket za uređivanje"),
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
            } else if (selectedpackages.length > 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content: Text(
                          "Odaberite samo jedan paket koji želite urediti"),
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
                      title: Text("Uredi paket"),
                      content: AddPackageForm(
                          isEditing: true, packageToEdit: selectedpackages[0]),
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
                              EditPackage(selectedpackages[0].id);
                              Navigator.of(context).pop();
                              selectedpackages = [];
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
          onPressed: selectedpackages.isEmpty
              ? () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Upozorenje"),
                            content: Text(
                                "Morate odabrati paket koji želite obrisati."),
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
                        title: Text("Izbriši obavijest!"),
                        content: SingleChildScrollView(
                          child: Text(
                              "Da li ste sigurni da želite obrisati paket?"),
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
                              for (Package n in selectedpackages) {
                                 DeletePackage(n.id);
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
      ],
    );
  }

 Widget AddPackageForm({bool isEditing = false, Package? packageToEdit}) {
  if (packageToEdit != null) {
    _nameController.text = packageToEdit.name!;
    _descriptionController.text = packageToEdit.description ?? "";
    _priceController.text = packageToEdit.price.toString();
  } else {
    _nameController.text = "";
    _descriptionController.text = "";
    _priceController.text = "0.0";
  }
  return Container(
    height: 450,
    width: 950,
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Naziv paketa:'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Obavezan unos!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Opis paketa:'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Obavezan unos!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Cijena paketa:'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Obavezan unos!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    ),
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
                              packages.forEach((notificationItem) {
                                notificationItem.isSelected = isAllSelected;
                              });

                              if (!isAllSelected) {
                                selectedpackages.clear();
                              } else {
                                selectedpackages = List.from(packages);
                              }
                            });
                          })),
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
                      "Cijena",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
                rows: packages.map((packageItem) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Checkbox(
                          value: packageItem.isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              packageItem.isSelected = value ?? false;
                              if (packageItem.isSelected == true) {
                                selectedpackages.add(packageItem);
                              } else {
                                selectedpackages.remove(packageItem);
                              }
                              isAllSelected = packages.every(
                                  (notification) => notification.isSelected);
                            });
                          },
                        ),
                      ),
                      DataCell(Text(packageItem.name!)),
                      DataCell(
                        Text(packageItem.description ?? ""),
                      ),
                      DataCell(
                        Text(packageItem.price!.toString()),
                      ),
                    ],
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }
}
