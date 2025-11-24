import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/prescription_result.dart';
import '../services/prescription_service.dart';
import 'monitoring_screen.dart';

class PrescriptionScreen extends StatelessWidget {
  final Patient patient;

  const PrescriptionScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final prescriptionService = PrescriptionService();
    final prescription = prescriptionService.generatePrescription(patient);

    return Scaffold(
      appBar: AppBar(
        title: Text(patient.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plano Terapêutico',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Divider(height: 24),
                    ...prescription.items.map(
                      (item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.medication,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          item.insulinName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('Dose: ${item.dose}'),
                            Text('Via: ${item.route}'),
                            Text('Horário: ${item.schedule}'),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Orientações Adicionais',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Divider(height: 24),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.monitor_heart,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      title: const Text(
                        'Monitorização',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(prescription.monitoring),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.warning_amber,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: const Text(
                        'Conduta para Hipoglicemia',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(prescription.hypoglycemia),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonitoringScreen(patient: patient),
                  ),
                );
              },
              icon: const Icon(Icons.assessment),
              label: const Text('Acompanhamento diário (simulado)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Observação: Protótipo acadêmico sem validade clínica.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
