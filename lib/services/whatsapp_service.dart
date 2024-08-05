import 'package:url_launcher/url_launcher.dart';

void sendWhatsAppMessage(String phoneNumber, String message) async {
  final url = "https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
