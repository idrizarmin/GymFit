import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.only(bottom: defaultPadding / 2),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 18, 16, 50),
                  width: 2.0,
                ),
              ),
            ),
            child: const Heder(pageTitle: "Klijenti")),
        const SizedBox(height: 16.0),
       
        
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
                      label: Text('Grupa'),
                    ),
                    const DataColumn(
                      label: Text('Spol'),
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
