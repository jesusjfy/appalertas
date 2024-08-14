import 'package:appalertas/models/user_model.dart';

class Area {
  final String name;
  final User head;
  final List<User> workers;

  Area({required this.name, required this.head, required this.workers});
}