class User {
  final String name;
  final String phoneNumber;
  final String whatsappNumber;
  final String position;

  User(
      {required this.name,
      required this.phoneNumber,
      required this.whatsappNumber,
      required this.position});

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      whatsappNumber: data['whatsappNumber'] ?? '',
      position: data['position'] ?? '',
    );
  }
}
