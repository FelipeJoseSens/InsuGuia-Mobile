import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/patient.dart';
import '../models/prescription_result.dart';
import '../services/prescription_service.dart';

class MonitoringRecord {
  final double glucose;
  final DateTime timestamp;
  final String correctionSuggestion;

  MonitoringRecord({
    required this.glucose,
    required this.timestamp,
    required this.correctionSuggestion,
  });
}

class MonitoringScreen extends StatefulWidget {
  final Patient patient;

  const MonitoringScreen({super.key, required this.patient});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  final _glucoseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<MonitoringRecord> _records = [];
  final PrescriptionService _prescriptionService = PrescriptionService();

  @override
  void dispose() {
    _glucoseController.dispose();
    super.dispose();
  }

  void _addRecord() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final glucose = double.parse(_glucoseController.text.trim());
    final prescription = _prescriptionService.generatePrescription(
      widget.patient,
      currentGlucoseMgDl: glucose,
    );

    final correctionItem = prescription.items.firstWhere(
      (item) => item.insulinName.contains('Regular'),
    );

    final record = MonitoringRecord(
      glucose: glucose,
      timestamp: DateTime.now(),
      correctionSuggestion: correctionItem.dose,
    );

    setState(() {
      _records.insert(0, record);
      _glucoseController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro adicionado com sucesso'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _clearHistory() {
    setState(() {
      _records.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Histórico limpo'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acompanhamento Diário'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Registrar Glicemia',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _glucoseController,
                      decoration: const InputDecoration(
                        labelText: 'Glicemia (mg/dL)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.bloodtype),
                        suffixText: 'mg/dL',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, informe a glicemia';
                        }
                        final glucose = double.tryParse(value.trim());
                        if (glucose == null || glucose <= 0) {
                          return 'Por favor, informe um valor válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _addRecord,
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Histórico',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (_records.isNotEmpty)
                  OutlinedButton.icon(
                    onPressed: _clearHistory,
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Limpar histórico'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _records.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_chart_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum registro ainda',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _records.length,
                    itemBuilder: (context, index) {
                      final record = _records[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: record.glucose > 140
                                ? Theme.of(context).colorScheme.errorContainer
                                : Theme.of(context).colorScheme.primaryContainer,
                            child: Icon(
                              Icons.monitor_heart,
                              color: record.glucose > 140
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            '${record.glucose.toStringAsFixed(0)} mg/dL',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(dateFormat.format(record.timestamp)),
                              const SizedBox(height: 4),
                              Text(
                                'Sugestão de correção: ${record.correctionSuggestion}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
