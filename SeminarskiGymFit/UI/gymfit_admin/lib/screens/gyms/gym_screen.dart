import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/screens/components/header.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: const Header(pageTitle: "Teretane"),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DataTable(
                      dataRowHeight: 100,
                      dataRowColor: MaterialStateProperty.all(
                          const Color.fromARGB(42, 241, 241, 241)),
                      columns: const <DataColumn>[
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('Ime')),
                        DataColumn(label: Text('Prezime')),
                        DataColumn(label: Text('Sadržaj')),
                        DataColumn(label: Text('Datum')),
                        DataColumn(label: Text('Viđeno')),
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
                            const DataCell(Text('Ime 1')),
                            const DataCell(Text('Prezime 1')),
                            const DataCell(Text('Sadržaj 1')),
                            const DataCell(Text('Datum 1')),
                            const DataCell(Icon(Icons.check_circle_outline,
                                color: Colors.green)),
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
                            const DataCell(Text('Ime 2')),
                            const DataCell(Text('Prezime 2')),
                            const DataCell(Text('Sadržaj 2')),
                            const DataCell(Text('Datum 2')),
                            const DataCell(Icon(Icons.check_circle_outline,
                                color: Colors.green)),
                          ],
                        ),
                        // Dodajte više redova prema potrebi
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
