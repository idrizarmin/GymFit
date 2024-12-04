import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/city.dart';
import 'package:gymfit_admin/models/country.dart';
import 'package:gymfit_admin/providers/city_provider.dart';
import 'package:gymfit_admin/providers/country_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<City> cities = <City>[];
  List<Country> countries = <Country>[];
  late CityProvider _cityProvider;
  late CountryProvider _countryProvider;
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  int? _selectedCountryId;
  bool _cityIsActive = false;
  @override
  void initState() {
    super.initState();
    _cityProvider = context.read<CityProvider>();
    _countryProvider = context.read<CountryProvider>();
    loadCities('');
    loadCountries();

    _searchController.addListener(() {
      final searchQuery = _searchController.text;
      loadCities(searchQuery);
    });
  }

  void loadCities(String? query) async {
    var params;
    try {
      if (query != null) {
        params = query;
      } else {
        params = null;
      }
      var citiesResponse = await _cityProvider.get({'params': params});
      setState(() {
        cities = citiesResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }
  void loadCountries() async {
    try {
      var countriesResponse = await _countryProvider.get(null);
      setState(() {
        countries = countriesResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void InsertCity() async {
    try {
      var newCity = {
        "name": _nameController.text,
        "zipCode": _zipCodeController.text,
        "countryId": _selectedCountryId,
        "isActive": _cityIsActive
      };
      var city = await _cityProvider.insert(newCity);
      if (city == "OK") {
        Navigator.of(context).pop();
        loadCities('');
        setState(() {
          _selectedCountryId = null;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void EditCity(int id) async {
    try {
      var newCity = {
        "id": id,
        "name": _nameController.text,
        "zipCode": _zipCodeController.text,
        "countryId": _selectedCountryId,
        "isActive": _cityIsActive
      };
      var city = await _cityProvider.edit(newCity);
      if (city == "OK") {
        Navigator.of(context).pop();
        loadCities('');
        setState(() {
          _selectedCountryId = null;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void DeleteCity(int id) async {
    try {
      var country = await _cityProvider.delete(id);
      if (country == "OK") {
        Navigator.of(context).pop();
        loadCities('');
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
                  child: const Header(pageTitle: "Gradovi")),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 1050,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 500,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 136,
                                      top: 8,
                                      right: 8), // Margine za input polje
                                  child: TextField(
                                    controller:
                                    _searchController, 
                                    decoration: const InputDecoration(
                                      hintText: 'Pretraga',
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8,
                                  right: 146), // Margine za dugme "Dodaj"
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: myButtonColor),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Dodaj grad'),
                                        content: SingleChildScrollView(
                                          child: AddCityForm(),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: myButtonColor,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Zatvori'),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: myButtonColor,
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                InsertCity();
                                              }
                                            },
                                            child: const Text('Spremi'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text("Dodaj"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildDataListView()
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }

  Widget AddCityForm({bool isEditing = false, City? cityToEdit}) {
    if (cityToEdit != null) {
      _nameController.text = cityToEdit.name;
      _zipCodeController.text = cityToEdit.zipCode;
      _selectedCountryId = cityToEdit.countryId;
    } else {
      _nameController.text = '';
      _zipCodeController.text = '';
      _selectedCountryId = null;
      _cityIsActive = false;
    }

    return SizedBox(
      height: 300,
      width: 350,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Odaberite državu'),
              value: _selectedCountryId,
              items: countries.map<DropdownMenuItem<int>>((Country country) {
                return DropdownMenuItem<int>(
                  value: country.id,
                  child: Text(country.name),
                );
              }).toList(),
              onChanged: (int? selectedCountryId) {
                setState(() {
                  _selectedCountryId = selectedCountryId;
                });
              },
              validator: (int? value) {
                if (value == null) {
                  return 'Odaberite državu!'; // Error message when no country is selected
                }
                return null; // No error if a country is selected
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Naziv grada'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Unesite naziv grada!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _zipCodeController,
              decoration: const InputDecoration(labelText: 'ZipCode'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Unesite ZipCode!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  value: _cityIsActive,
                  onChanged: (bool? value) {
                    _cityIsActive = !_cityIsActive;
                  },
                ),
                const Text('Aktivan'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              columns: const [
                DataColumn(
                    label: Expanded(
                  flex: 2,
                  child: Text(
                    "ID",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                )),
                DataColumn(
                    label: Expanded(
                  flex: 5,
                  child: Text(
                    "Name",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                )),
                DataColumn(
                    label: Expanded(
                  flex: 4,
                  child: Text(
                    "ZipCode",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                )),
                DataColumn(
                    label: Expanded(
                  flex: 4,
                  child: Text(
                    "IsActive",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                )),
                DataColumn(
                    label: Expanded(
                  flex: 4,
                  child: Text(
                    "Country",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                )),
                DataColumn(
                    label: Expanded(
                  flex: 2,
                  child: Text(
                    "",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                )),
                DataColumn(
                    label: Expanded(
                  flex: 2,
                  child: Text(
                    "",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                )),
              ],
              rows: cities
                      .map((City e) => DataRow(cells: [
                            DataCell(Text(e.id.toString() ?? "")),
                            DataCell(Text(e.name.toString() ?? "")),
                            DataCell(Text(e.zipCode.toString() ?? "")),
                            DataCell(Text(e.isActive.toString() ?? "")),
                            DataCell(
                                Text(e.country.abbreviation.toString() ?? "")),
                            DataCell(
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: myButtonColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isEditing = true;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(isEditing
                                            ? 'Uredi grad'
                                            : 'Dodaj grad'),
                                        content: SingleChildScrollView(
                                          child: AddCityForm(
                                              isEditing: isEditing,
                                              cityToEdit:
                                                  e), // Prosleđivanje podataka o državi
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: myButtonColor,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Zatvorite modal
                                            },
                                            child: const Text('Zatvori'),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: myButtonColor,
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                EditCity(e.id);
                                              }
                                            },
                                            child: const Text('Spremi'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text("Uredi"),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: myButtonDeleteColor,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Izbrisi grad"),
                                        content: const SingleChildScrollView(
                                            child: Text(
                                                "Da li ste sigurni da zelite obisati grad?")),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: myButtonColor,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Zatvorite modal
                                            },
                                            child: const Text('Odustani'),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  myButtonDeleteColor,
                                            ),
                                            onPressed: () {
                                              DeleteCity(e.id);
                                            },
                                            child: const Text('Izbrisi'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text("Obriši"),
                              ),
                            ),
                          ]))
                      .toList() ??
                  [])),
    );
  }
}
