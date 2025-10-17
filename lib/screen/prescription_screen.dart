import 'package:flutter/material.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prescrição Sugerida')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("📋 Prescrição Gerada (Exemplo)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Dieta: Normal"),
            Text("Monitorização Glicêmica: 4x ao dia"),
            Text("Insulina Basal: NPH 0.2 UI/kg/dia"),
            Text("Insulina de Ação Rápida: Regular antes das refeições"),
            Text("Conduta Hipoglicemia: Oferecer 15g de carboidrato e reavaliar."),
          ],
        ),
      ),
    );
  }
}
