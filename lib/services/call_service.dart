import 'package:url_launcher/url_launcher.dart';

class CallService {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      }
      //  else {
      //   print('No se pudo lanzar $telUri');
      // }
    } catch (e) {
      print('Error al intentar realizar la llamada: $e');
    }
  }
}
