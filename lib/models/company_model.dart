import 'package:appalertas/models/area_model.dart';

class Company {
  final String name;
  final List<Area> areas;
  final double latitude;
  final double longitude;

  Company({
    required this.name,
    required this.areas,
    required this.latitude,
    required this.longitude,
  });

  factory Company.fromFirestore(Map<String, dynamic> data, List<Map<String, dynamic>> areasData) {
    return Company(
      name: data['name'] ?? '',
      areas: areasData.map((areaData) => Area.fromFirestore(areaData)).toList(),
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
