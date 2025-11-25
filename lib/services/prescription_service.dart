import '../models/patient.dart';
import '../models/prescription_result.dart';

class PrescriptionService {
  PrescriptionResult generatePrescription(
    Patient patient, {
    double? currentGlucoseMgDl,
  }) {

    final double tdd = patient.weight * 0.5;

    final double rawBasalDose = patient.weight * 0.2;
    

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

    if (currentGlucoseMgDl != null && currentGlucoseMgDl < 70) {
        correctionDose = '🚨 HIPOGLICEMIA: Ingerir 15g carboidratos e repetir destro em 15min';
    }

    else if (currentGlucoseMgDl == null) {
      correctionDose = 'Conforme Glicemia (esquema de correção)';
    } 

    else {
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

        correctionDose = 'Nenhuma (Glicemia dentro da meta)';
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