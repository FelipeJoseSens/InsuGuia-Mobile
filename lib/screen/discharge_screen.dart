import 'package:flutter/material.dart';

class DischargeScreen extends StatelessWidget {
  const DischargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alta Hospitalar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("🏠 Orientações de Alta", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text("1. Continuar monitoramento de glicemia capilar."),
            Text("2. Seguir plano alimentar orientado."),
            Text("3. Retornar para acompanhamento com endocrinologista."),
            Text("4. Reforçar orientações sobre hipoglicemia."),
          ],
        ),
      ),
    );
  }
}
