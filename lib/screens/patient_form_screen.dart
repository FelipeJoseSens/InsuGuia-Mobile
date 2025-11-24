import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final PatientService _patientService = PatientService();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _creatinineController = TextEditingController();

  String? _selectedGender;
  String? _selectedLocation;

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _creatinineController.dispose();
    super.dispose();
  }

  Future<void> _savePatient() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    const uuid = Uuid();
    final patient = Patient(
      id: uuid.v4(),
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      weight: double.parse(_weightController.text.trim()),
      gender: _selectedGender!,
      height: _heightController.text.isNotEmpty
          ? double.tryParse(_heightController.text.trim())
          : null,
      creatinine: _creatinineController.text.isNotEmpty
          ? double.tryParse(_creatinineController.text.trim())
          : null,
      admissionLocation: _selectedLocation,
    );

    final success = await _patientService.addPatient(patient);

    setState(() {
      _isSaving = false;
    });

    if (mounted) {
      if (success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao salvar paciente'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Paciente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, informe o nome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Idade *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                      suffixText: 'anos',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, informe a idade';
                      }
                      final age = int.tryParse(value.trim());
                      if (age == null || age <= 0) {
                        return 'Por favor, informe uma idade válida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg) *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monitor_weight),
                      suffixText: 'kg',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, informe o peso';
                      }
                      final weight = double.tryParse(value.trim());
                      if (weight == null || weight <= 0) {
                        return 'Por favor, informe um peso válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Sexo *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                      DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                      DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione o sexo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.height),
                      suffixText: 'cm',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _creatinineController,
                    decoration: const InputDecoration(
                      labelText: 'Creatinina (mg/dL)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.science),
                      suffixText: 'mg/dL',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    decoration: const InputDecoration(
                      labelText: 'Local de internação',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.local_hospital),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Enfermaria', child: Text('Enfermaria')),
                      DropdownMenuItem(value: 'UTI', child: Text('UTI')),
                      DropdownMenuItem(value: 'Outros', child: Text('Outros')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedLocation = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _savePatient,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Salvar Paciente'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
