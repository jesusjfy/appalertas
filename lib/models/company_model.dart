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
}
