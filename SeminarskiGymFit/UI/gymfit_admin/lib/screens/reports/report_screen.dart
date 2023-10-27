import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _FinancialReportScreenState createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<ReportScreen> {
  // Definirajte kontrolere za unos podataka
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _profitsController = TextEditingController();

  // Metoda za obračun profita
  void calculateProfit() {
    double revenue = double.tryParse(_revenueController.text) ?? 0.0;
    double expenses = double.tryParse(_expensesController.text) ?? 0.0;
    double profit = revenue - expenses;

    _profitsController.text = profit.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _revenueController,
              decoration: InputDecoration(labelText: 'Prihod'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _expensesController,
              decoration: InputDecoration(labelText: 'Troškovi'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: calculateProfit,
              child: Text('Izračunaj Profit'),
            ),
            TextField(
              controller: _profitsController,
              decoration: InputDecoration(labelText: 'Profit'),
              readOnly: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ovdje dodajte logiku za spremanje financijskog izvještaja
                double revenue = double.tryParse(_revenueController.text) ?? 0.0;
                double expenses = double.tryParse(_expensesController.text) ?? 0.0;
                double profit = double.tryParse(_profitsController.text) ?? 0.0;

                // Spremite izvještaj ili posaljite na server
                // Ili obratite se odgovarajućoj usluzi za spremanje podataka
              },
              child: Text('Spremi Izvještaj'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _revenueController.dispose();
    _expensesController.dispose();
    _profitsController.dispose();
    super.dispose();
  }
}
