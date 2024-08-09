import 'package:url_launcher/url_launcher.dart';

class WhatsappService {
  Future<void> sendWhatsappMessage(String phoneNumber, String message) async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'api.whatsapp.com',
      path: 'send',
      queryParameters: {
        'phone': phoneNumber,
        'text': message,
      },
    );
    try {
      if (await launchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        print('No se puede lanzar $whatsappUri');
      }
    } catch (e) {
      print('Error enviando mensaje de WhatsApp: $e');
    }
  }
}