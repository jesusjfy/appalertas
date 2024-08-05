import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;

  void sendSmsMessage(String message, String recipient) async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    if (permissionsGranted != null && permissionsGranted) {
      telephony.sendSms(
        to: recipient,
        message: message,
      );
    } else {
      print("Permissions not granted");
    }
  }
}
