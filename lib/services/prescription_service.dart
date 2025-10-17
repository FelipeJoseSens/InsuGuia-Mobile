import '../models/patient.dart';

class PrescriptionService {
  String generatePrescription(Patient patient) {
    return """
    Prescrição Sugerida:
    - Dieta: Normal
    - Insulina Basal: NPH ${(patient.weight * 0.2).toStringAsFixed(1)} UI/dia
    - Ação Rápida: Regular antes das refeições
    - Observações: Ajustar conforme glicemia capilar.
    """;
  }
}
