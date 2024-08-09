import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;

  void sendSmsMessage(String message, String recipient) async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    if (permissionsGranted != null && permissionsGranted) {
      telephony.sendSms(
        to: recipient,
        message: message,
      ).catchError((error) {
        print("Error enviando SMS: $error");
      });
    } else {
      print("No tiene permiso suficiente");
    }
  }

  Future<void> sendSms(String message, String recipient) async {
    try {
      await telephony.sendSms(
          to: recipient, message: message);
    } catch (e) {
      print('Error enviando SMS: $e');
    }
  }
}
