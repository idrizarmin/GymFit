import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/screens/components/header.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

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
            child: const Heder(pageTitle: "Termini -rezervacije ")),
        const SizedBox(height: 16.0),
        Row(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 400, // Adjust the width as needed
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Klijenti",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(defaultPadding * 0.75),
                        margin:
                            const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Icon(Icons.search_outlined)),
                  ),
                ),
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
                  hintText: "Treneri",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(defaultPadding * 0.75),
                        margin:
                            const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Icon(Icons.search_outlined)),
                  ),
                ),
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
                border: Border.all(color: Colors.white), // Boja bordera
                borderRadius: BorderRadius.circular(10.0), // Radijus zaobljenja
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Puni širina dropdowna
                icon: const Icon(Icons.arrow_drop_down),
                hint: const Text('  Grupa'),
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
        ),
      ]),
    ));
  }
}
