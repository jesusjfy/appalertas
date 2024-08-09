import 'package:flutter/material.dart';

import '../services/call_service.dart';
import '../services/notification_service.dart';
import '../services/sms_service.dart';
import '../services/whatsapp_service.dart';

class HomePage extends StatelessWidget {
  final NotificationService _notificationService = NotificationService();
  final SmsService _smsService = SmsService();
  final CallService _callService = CallService();
  final WhatsappService _whatsappService = WhatsappService();

  HomePage() {
    _notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _notificationService.showNotification('Test', 'Hola');
              },
              child: Text('Ver Notificación'),
            ),
            ElevatedButton(
              onPressed: () {
                _smsService.sendSmsMessage('Mensaje enviado', '+15551234567');
              },
              child: Text('Enviar SMS'),
            ),
            ElevatedButton(
              onPressed: () {
                _callService.makePhoneCall('+15551234567');
              },
              child: Text('Realizar llamada'),
            ),
            ElevatedButton(
              onPressed: () {
                _whatsappService.sendWhatsappMessage('+51931686610', 'Hola');
              },
              child: Text('Enviar mensaje WhatsApp'),
            ),
          ],
        ),
      ),
    );
  }
}
