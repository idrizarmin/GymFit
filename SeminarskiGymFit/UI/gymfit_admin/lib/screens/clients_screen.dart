import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/screens/components/header.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
      children: [ Container(
            padding: EdgeInsets.only(bottom: defaultPadding / 2),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 18, 16, 50),
                  width: 2.0,
                ),
              ),
            ),
            child: Heder(pageTitle: "Klijenti")),
        SizedBox(height: 16.0),
        Row(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Boja bordera
                borderRadius: BorderRadius.circular(10.0), // Radijus zaobljenja
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Puni širina dropdowna
                icon: Icon(Icons.arrow_drop_down),
                hint: Text('  Teretana'),
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
                underline: Text(""),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Boja bordera
                borderRadius: BorderRadius.circular(10.0), // Radijus zaobljenja
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Puni širina dropdowna
                icon: Icon(Icons.arrow_drop_down),
                hint: Text('  Spol'),
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
                underline: Text(""),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Boja bordera
                borderRadius: BorderRadius.circular(10.0), // Radijus zaobljenja
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Puni širina dropdowna
                icon: Icon(Icons.arrow_drop_down),
                hint: Text('  Grupa'),
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
                underline: Text(""),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Boja bordera
                borderRadius: BorderRadius.circular(10.0), // Radijus zaobljenja
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Puni širina dropdowna
                icon: Icon(Icons.arrow_drop_down),
                hint: Text('  Status'),
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
                underline: Text(""),
              ),
            ),
          ),
        ]),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 400, // Adjust the width as needed
              child: TextField(
      decoration: InputDecoration(
        hintText: "Pretraga",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg", color: Colors.white,),
          ),
        ),
      ),)
            ),
            SizedBox(
              width: 20,
            ),
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
                SizedBox(width: 16.0),
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
                SizedBox(width: 16.0),
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
        SizedBox(
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
                      Color.fromARGB(42, 241, 241, 241)),
                  columns: <DataColumn>[
                    DataColumn(
                      label: Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Ovdje implementirajte logiku za promjenu stanja checkboxa
                        },
                      ),
                    ),
                    DataColumn(
                      label: Text('Redni broj'),
                    ),
                    DataColumn(
                      label: Text('Slika'),
                    ),
                    DataColumn(
                      label: Text('Ime i prezime'),
                    ),
                    DataColumn(
                      label: Text('Teretana'),
                    ),
                    DataColumn(
                      label: Text('Grupa'),
                    ),
                    DataColumn(
                      label: Text('Spol'),
                    ),
                    DataColumn(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 1'),
                        ),
                        DataCell(
                          Text('Teretana 1'),
                        ),
                        DataCell(
                          Text('Grupa 1'),
                        ),
                        DataCell(
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
                        DataCell(
                          Text('2'),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/user1.jpg',
                              height: 250,
                              width: 200,
                            ),
                          ),
                        ),
                        DataCell(
                          Text('Ime Prezime 2'),
                        ),
                        DataCell(
                          Text('Teretana 2'),
                        ),
                        DataCell(
                          Text('Grupa 2'),
                        ),
                        DataCell(
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
