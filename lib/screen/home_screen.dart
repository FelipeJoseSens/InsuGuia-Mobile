import 'package:flutter/material.dart';
import 'patient_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InsuGuia Mobile')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Cadastrar Paciente'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientFormScreen()),
            );
          },
        ),
      ),
    );
  }
}
