import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';

class DischargeScreen extends StatelessWidget {
  final Patient patient;

  const DischargeScreen({super.key, required this.patient});

  Future<void> _confirmDischarge(BuildContext context) async {
    final service = PatientService();
    final success = await service.dischargePatient(patient.id);

    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paciente recebeu alta com sucesso!')),
        );

        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao processar alta.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alta Hospitalar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.green.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🏠 Orientações de Alta", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                    SizedBox(height: 12),
                    Text("1. Continuar monitoramento de glicemia capilar."),
                    Text("2. Seguir plano alimentar orientado."),
                    Text("3. Retornar para acompanhamento com endocrinologista."),
                    Text("4. Reforçar orientações sobre hipoglicemia."),
                  ],
                ),
              ),
            ),
            
            const Spacer(),

            if (!patient.isDischarged)
              ElevatedButton.icon(
                onPressed: () => _confirmDischarge(context),
                icon: const Icon(Icons.check_circle),
                label: const Text('CONFIRMAR ALTA E ARQUIVAR'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              )
            else
              const Center(
                child: Text("Este paciente já recebeu alta.", 
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
              ),
          ],
        ),
      ),
    );
  }
}