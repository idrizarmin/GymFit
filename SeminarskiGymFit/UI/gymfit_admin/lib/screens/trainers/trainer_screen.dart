import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/screens/components/header.dart';

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({Key? key}) : super(key: key);

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
            child: const Heder(pageTitle: "Treneri")),
        const SizedBox(height: 16.0),
        Row(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Boja bordera
                borderRadius: BorderRadius.circular(10.0), // Radijus zaobljenja
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Puni širina dropdowna
                icon: const Icon(Icons.arrow_drop_down),
                hint: const Text('  Teretana'),
                items:
                    <String>['Item 1', 'Item 2', 'Item 3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Logika za promjenu vrijednosti Dropdown liste
                },
                underline: const Text(""),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Boja bordera
                borderRadius: BorderRadius.circular(10.0), // Radijus zaobljenja
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Puni širina dropdowna
                icon: const Icon(Icons.arrow_drop_down),
                hint: const Text('  Spol'),
                items:
                    <String>['Item 1', 'Item 2', 'Item 3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Logika za promjenu vrijednosti Dropdown liste
                },
                underline: const Text(""),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 400, // Adjust the width as needed
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Pretraži trenere',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                ),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {},
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
                  onPressed: () {},
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
                  onPressed: () {},
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
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
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
                  dataRowHeight: 100,
                  dataRowColor: MaterialStateProperty.all(
                      const Color.fromARGB(42, 241, 241, 241)),
                  columns: <DataColumn>[
                    DataColumn(
                      label: Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Ovdje implementirajte logiku za promjenu stanja checkboxa
                        },
                      ),
                    ),
                    const DataColumn(
                      label: Text('Redni broj'),
                    ),
                    const DataColumn(
                      label: Text('Slika'),
                    ),
                    const DataColumn(
                      label: Text('Ime i prezime'),
                    ),
                    const DataColumn(
                      label: Text('Teretana'),
                    ),
                    const DataColumn(
                      label: Text('Telefon'),
                    ),
                    const DataColumn(
                      label: Text('Email'),
                    ),
                    const DataColumn(
                      label: Text('Status'),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        const DataCell(
                          Text('Teretana 1'),
                        ),
                        const DataCell(
                          Text('Grupa 1'),
                        ),
                        const DataCell(
                          Text('Muški'),
                        ),
                        const DataCell(
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Ovdje implementirajte logiku za promjenu stanja checkboxa
                            },
                          ),
                        ),
                        const DataCell(
                          Text('2'),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        const DataCell(
                          Text('Ime Prezime 2'),
                        ),
                        const DataCell(
                          Text('Teretana 2'),
                        ),
                        const DataCell(
                          Text('Grupa 2'),
                        ),
                        const DataCell(
                          Text('Ženski'), // Možete prilagoditi spol
                        ),
                        const DataCell(
                          Icon(Icons.error_outline, color: Colors.red),
                        ),
                      ],
                    ),
                    // Dodajte više redova prema potrebi
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
