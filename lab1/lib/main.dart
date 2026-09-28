import 'package:flutter/material.dart';

void main() {
  runApp(const SalaryCalculatorApp());
}

class SalaryCalculatorApp extends StatelessWidget {
  const SalaryCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Salariu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SalaryCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SalaryCalculatorScreen extends StatefulWidget {
  const SalaryCalculatorScreen({super.key});

  @override
  State<SalaryCalculatorScreen> createState() => _SalaryCalculatorScreenState();
}

class _SalaryCalculatorScreenState extends State<SalaryCalculatorScreen> {
  final TextEditingController _grossSalaryController = TextEditingController();
  
  // Rata de impozitare selectata (default 12%)
  double _taxRate = 0.12;
  String _employeeType = 'Standard (12%)';

  double _netSalary = 0.0;
  double _totalTaxes = 0.0;

  void _calculateSalary() {
    double gross = double.tryParse(_grossSalaryController.text) ?? 0.0;
    
    setState(() {
      _totalTaxes = gross * _taxRate;
      _netSalary = gross - _totalTaxes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Salariu Net'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. INPUT: Salariul brut (TextField)
            TextField(
              controller: _grossSalaryController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Salariu Brut',
                hintText: 'Introduceți suma brută',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // 2. UI CONTROL: DropdownButton pentru selectarea tipului de angajat
            DropdownButtonFormField<double>(
              value: _taxRate,
              decoration: const InputDecoration(
                labelText: 'Tip Angajat / Impozitare',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              items: const [
                DropdownMenuItem(
                  value: 0.12,
                  child: Text('Angajat Standard (Impozit 12%)'),
                ),
                DropdownMenuItem(
                  value: 0.0,
                  child: Text('Sector IT / Scutit (Impozit 0%)'),
                ),
                DropdownMenuItem(
                  value: 0.06,
                  child: Text('Regim Redus (Impozit 6%)'),
                ),
              ],
              onChanged: (double? newValue) {
                if (newValue != null) {
                  setState(() {
                    _taxRate = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 25),

            // 3. UI CONTROL: ElevatedButton
            ElevatedButton.icon(
              onPressed: _calculateSalary,
              icon: const Icon(Icons.calculate),
              label: const Text('Calculează Salariul Net', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 30),

            // 4. OUTPUT: Rezultate afisate în Text / Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Suma Impozitelor:', style: TextStyle(fontSize: 16)),
                        Text(
                          '${_totalTaxes.toStringAsFixed(2)} MDL',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Salariu Net:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                          '${_netSalary.toStringAsFixed(2)} MDL',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}