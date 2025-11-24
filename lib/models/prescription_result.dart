class PrescriptionItem {
  final String insulinName;
  final String dose;
  final String route;
  final String schedule;

  PrescriptionItem({
    required this.insulinName,
    required this.dose,
    required this.route,
    required this.schedule,
  });
}

class PrescriptionResult {
  final List<PrescriptionItem> items;
  final String monitoring;
  final String hypoglycemia;

  PrescriptionResult({
    required this.items,
    required this.monitoring,
    required this.hypoglycemia,
  });
}
