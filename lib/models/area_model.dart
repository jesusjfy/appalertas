import 'package:appalertas/models/user_model.dart';

class Area {
  final String name;
  final User head;
  final List<User> workers;

  Area({required this.name, required this.head, required this.workers});

  factory Area.fromFirestore(Map<String, dynamic> data) {
    return Area(
      name: data['name'] ?? '',
      head: User.fromFirestore(data['head'] as Map<String, dynamic>? ?? {}),
      workers: (data['workers'] as List<dynamic>? ?? []).map((workerData) {
        return User.fromFirestore(workerData as Map<String, dynamic>? ?? {});
      }).toList(),
    );
  }
}
