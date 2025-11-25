import 'dart:convert';

class MonitoringRecord {
  final double glucose;
  final DateTime timestamp;
  final String correctionSuggestion;

  MonitoringRecord({
    required this.glucose,
    required this.timestamp,
    required this.correctionSuggestion,
  });

  Map<String, dynamic> toJson() {
    return {
      'glucose': glucose,
      'timestamp': timestamp.toIso8601String(),
      'correctionSuggestion': correctionSuggestion,
    };
  }

  factory MonitoringRecord.fromJson(Map<String, dynamic> json) {
    return MonitoringRecord(
      glucose: (json['glucose'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      correctionSuggestion: json['correctionSuggestion'],
    );
  }
}

class Patient {
  final String id;
  final String name;
  final int age;
  final double weight;
  final String gender;
  final double? height;
  final double? creatinine;
  final String? admissionLocation;
  final bool isDischarged;
  final List<MonitoringRecord> monitoringHistory; 

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.gender,
    this.height,
    this.creatinine,
    this.admissionLocation,
    this.isDischarged = false,
    this.monitoringHistory = const [], 
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
      'isDischarged': isDischarged,
      'monitoringHistory': monitoringHistory.map((e) => e.toJson()).toList(),
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
      isDischarged: json['isDischarged'] ?? false,
      monitoringHistory: (json['monitoringHistory'] as List<dynamic>?)
              ?.map((e) => MonitoringRecord.fromJson(e))
              .toList() ??
          [],
    );
  }

  Patient copyWith({
    String? id,
    String? name,
    int? age,
    double? weight,
    String? gender,
    double? height,
    double? creatinine,
    String? admissionLocation,
    bool? isDischarged,
    List<MonitoringRecord>? monitoringHistory,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      creatinine: creatinine ?? this.creatinine,
      admissionLocation: admissionLocation ?? this.admissionLocation,
      isDischarged: isDischarged ?? this.isDischarged,
      monitoringHistory: monitoringHistory ?? this.monitoringHistory,
    );
  }
}