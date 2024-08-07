import 'package:url_launcher/url_launcher.dart';

void sendWhatsAppMessage(String phoneNumber, String message) async {
  final url = "https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

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
      if (await canLaunch(whatsappUri.toString())) {
        await launch(whatsappUri.toString());
      } else {
        print('Could not launch $whatsappUri');
      }
    } catch (e) {
      print('Error sending WhatsApp message: $e');
    }
  }
}