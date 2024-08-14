import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;

  Future<void> sendSms(String phoneNumber, String message) async {
    try {
      await telephony.sendSms(to: phoneNumber, message: message);
    } catch (e) {
      throw 'Error al enviar SMS: $e';
    }
  }
}