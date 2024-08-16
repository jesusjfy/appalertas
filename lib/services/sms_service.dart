import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getSmsTemplate() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('notification_templates')
          .where('isActive', isEqualTo: true)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('No hay templates activos disponibles');
      }

      final activeTemplate = snapshot.docs.first;
      return activeTemplate.get('body') as String;
    } catch (e) {
      throw Exception('Falló en cargar el SMS template activo: $e');
    }
  }

  Future<void> sendSms(String phoneNumber) async {
    String message_template = await getSmsTemplate();
    try {
      await telephony.sendSms(to: phoneNumber, message: message_template);

      await _firestore.collection('notification_history').add({
        'timestamp': Timestamp.now(),
        'recipient': phoneNumber,
        'type': 'SMS',
        'message': message_template,
        'status': 'Enviado',
      });
    } catch (e) {
      await _firestore.collection('notification_history').add({
        'timestamp': Timestamp.now(),
        'recipient': phoneNumber,
        'type': 'SMS',
        'message': message_template,
        'status': 'Error',
      });
      throw 'Error al enviar SMS: $e';
    }
  }
}
