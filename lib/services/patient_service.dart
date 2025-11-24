import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/patient.dart';

class PatientService {
  static const String _storageKey = 'patients';

  Future<List<Patient>> loadPatients() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? patientsJson = prefs.getString(_storageKey);

      if (patientsJson == null || patientsJson.isEmpty) {
        return [];
      }

      final List<dynamic> decoded = json.decode(patientsJson);
      return decoded.map((json) => Patient.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> savePatients(List<Patient> patients) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonList =
          patients.map((patient) => patient.toJson()).toList();
      final String encoded = json.encode(jsonList);
      return await prefs.setString(_storageKey, encoded);
    } catch (e) {
      return false;
    }
  }

  Future<bool> addPatient(Patient patient) async {
    try {
      final patients = await loadPatients();
      patients.add(patient);
      return await savePatients(patients);
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePatient(String patientId) async {
    try {
      final patients = await loadPatients();
      patients.removeWhere((p) => p.id == patientId);
      return await savePatients(patients);
    } catch (e) {
      return false;
    }
  }
}
