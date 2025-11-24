class Patient {
  final String id;
  final String name;
  final int age;
  final double weight;
  final String gender;
  final double? height;
  final double? creatinine;
  final String? admissionLocation;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.gender,
    this.height,
    this.creatinine,
    this.admissionLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'weight': weight,
      'gender': gender,
      'height': height,
      'creatinine': creatinine,
      'admissionLocation': admissionLocation,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      weight: (json['weight'] as num).toDouble(),
      gender: json['gender'] as String,
      height: json['height'] != null ? (json['height'] as num).toDouble() : null,
      creatinine: json['creatinine'] != null ? (json['creatinine'] as num).toDouble() : null,
      admissionLocation: json['admissionLocation'] as String?,
    );
  }
}
