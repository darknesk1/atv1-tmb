import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TMB()));

class TMB extends StatefulWidget {
  const TMB({super.key});

  @override
  State<TMB> createState() => _TMBState();
}

class _TMBState extends State<TMB> {
  final idade = TextEditingController();
  final peso = TextEditingController();
  final altura = TextEditingController();

  String genero = "M";
  String atividade = "Sedentário";
  double resultado = 0;

  final fta = {
    "Sedentário": 1.2,
    "Leve": 1.375,
    "Moderado": 1.55,
    "Alto": 1.725,
    "Extremo": 1.9,
  };

  void calcular() {
    double p = double.tryParse(peso.text) ?? 0;
    double a = double.tryParse(altura.text) ?? 0;
    int i = int.tryParse(idade.text) ?? 0;

    double base = genero == "M"
        ? 66 + (13.7 * p) + (5 * a) - (6.8 * i)
        : 655 + (9.6 * p) + (1.8 * a) - (4.7 * i);

    setState(() {
      resultado = base * fta[atividade]!;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
 appBar: AppBar(title: const Text("TMB")),
  body: Padding(
  padding: const EdgeInsets.all(10),
  child: Column(
  children: [
TextField(controller: idade, decoration: const InputDecoration(labelText: "Idade")),
TextField(controller: peso, decoration: const InputDecoration(labelText: "Peso")),
            TextField(controller: altura, decoration: const InputDecoration(labelText: "Altura")),

            Row(
              children: [
                Radio(value: "M", groupValue: genero, onChanged: (v) => setState(() => genero = v!)),
                const Text("M"),
                Radio(value: "F", groupValue: genero, onChanged: (v) => setState(() => genero = v!)),
                const Text("F"),
              ],
            ),

            DropdownButton<String>(
              value: atividade,
              isExpanded: true,
              items: fta.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => atividade = v!),
            ),

  ElevatedButton(onPressed: calcular, child: const Text("Calcular")),

 Text(resultado == 0 ? "Resultado" : "${resultado.toStringAsFixed(1)} kcal/dia")
          ],
        ),
      ),
    );
  }
}