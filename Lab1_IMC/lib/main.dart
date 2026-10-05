import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const IMCScreen(),
    );
  }
}

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  // preluarea textului
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double? bmi;
  String category = '';
  String? errorMessage;

  // eliberare memorie
  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void calculateBMI() {
    // inchidere tastatura
    FocusScope.of(context).unfocus();

    // ,.
    final weightText = weightController.text.replaceAll(',', '.');
    final heightText = heightController.text.replaceAll(',', '.');

    final double? weight = double.tryParse(weightText);
    final double? heightCm = double.tryParse(heightText);

    // validare date
    if (weight == null || heightCm == null || weight <= 0 || heightCm <= 0) {
      setState(() {
        errorMessage = 'Te rugăm să introduci valori valide!';
        bmi = null;
      });
      return;
    }

    final double heightM = heightCm / 100;
    final double result = weight / (heightM * heightM);

    String resultCategory;
    if (result < 18.5) {
      resultCategory = 'Subponderal';
    } else if (result < 25) {
      resultCategory = 'Normal';
    } else if (result < 30) {
      resultCategory = 'Supraponderal';
    } else {
      resultCategory = 'Obezitate';
    }

    setState(() {
      bmi = result;
      category = resultCategory;
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator IMC'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      //  previne eroarea de overflow când apare tastatura
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Greutate (kg)',
                hintText: 'ex: 70',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Înălțime (cm)',
                hintText: 'ex: 175',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('CALCULEAZĂ IMC', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 30),

            // eroare date invalide
            if (errorMessage != null) ...[
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],

            if (bmi != null) ...[
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'IMC: ${bmi!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Categorie: $category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: _getCategoryColor(category),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String cat) {
    switch (cat) {
      case 'Subponderal':
        return Colors.orange;
      case 'Normal':
        return Colors.green;
      case 'Supraponderal':
        return Colors.orangeAccent;
      default:
        return Colors.red;
    }
  }
}