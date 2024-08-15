import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendSms(String phoneNumber, String message) async {
    try {
      await telephony.sendSms(to: phoneNumber, message: message);

      await _firestore.collection('notification_history').add({
        'timestamp': Timestamp.now(),
        'recipient': phoneNumber,
        'type': 'SMS',
        'message': message,
        'status': 'Enviado',
      });
    } catch (e) {
      await _firestore.collection('notification_history').add({
        'timestamp': Timestamp.now(),
        'recipient': phoneNumber,
        'type': 'SMS',
        'message': message,
        'status': 'Error',
      });
      throw 'Error al enviar SMS: $e';
    }
  }
}
