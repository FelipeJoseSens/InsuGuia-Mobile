import '../models/patient.dart';
import '../models/prescription_result.dart';

class PrescriptionService {
  PrescriptionResult generatePrescription(
    Patient patient, {
    double? currentGlucoseMgDl,
  }) {
    // --- 1. CÁLCULOS BÁSICOS ---
    
    // TDD (Total Daily Dose) - Dose Total Diária: 0.5 UI/kg
    final double tdd = patient.weight * 0.5;
    
    // Cálculo da Basal (NPH): 0.2 UI/kg
    final double rawBasalDose = patient.weight * 0.2;
    
    // ARREDONDAMENTO DE SEGURANÇA (BASAL):
    // Arredonda para o inteiro mais próximo (ex: 10.6 -> 11; 10.4 -> 10)
    // Isso garante que a dose possa ser aspirada em seringas comuns de 1ml.
    final int basalDose = rawBasalDose.round(); 

    final double correctionFactor = 1500.0 / tdd;
    
    final double targetGlucose = 140.0;


    final basalItem = PrescriptionItem(
      insulinName: 'Insulina NPH (Basal)',
      dose: '$basalDose UI',
      route: 'SC',
      schedule: 'Aplicar às 22:00',
    );


    String correctionDose;
    
    if (currentGlucoseMgDl == null) {

      correctionDose = 'Conforme Glicemia (esquema de correção)';
    } else {

      final double diff = currentGlucoseMgDl - targetGlucose;
      
      if (diff > 0) {
        final double rawCalculatedDose = diff / correctionFactor;
        
        final int calculatedDose = rawCalculatedDose.round(); 
        
        if (calculatedDose > 0) {
          correctionDose = '$calculatedDose UI (AGORA)';
        } else {
          correctionDose = 'Nenhuma (Dose calculada < 1 UI)';
        }
      } else {
        correctionDose = 'Nenhuma';
      }
    }

    final correctionItem = PrescriptionItem(
      insulinName: 'Insulina Regular (Correção)',
      dose: correctionDose,
      route: 'SC',
      schedule: 'Antes do café, almoço e jantar (AC) e se Glicemia > 140 mg/dL',
    );

    return PrescriptionResult(
      items: [basalItem, correctionItem],
      monitoring:
          'Monitorização glicêmica capilar: antes das refeições e à noite (mínimo 4x/dia).',
      hypoglycemia:
          'Hipoglicemia: oferecer 15 g de carboidrato por via oral (se seguro), reavaliar em 15 min; se grave, seguir protocolo institucional.',
    );
  }
}