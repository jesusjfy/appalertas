import 'package:flutter/material.dart';

import '../services/call_service.dart';
import '../services/notification_service.dart';
import '../services/sms_service.dart';
import '../services/whatsapp_service.dart';

class HomePage extends StatelessWidget {
  final NotificationService _notificationService = NotificationService();
  final SmsService _smsService = SmsService();

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
                _notificationService.showNotification('Test', 'This is a test notification');
              },
              child: Text('Show Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                _smsService.sendSmsMessage('This is a test message', '+51931686610');
              },
              child: Text('Send SMS'),
            ),
            ElevatedButton(
              onPressed: () {
                makeCall('+51931686610');
              },
              child: Text('Make Call'),
            ),
            ElevatedButton(
              onPressed: () {
                sendWhatsAppMessage('+51931686610', 'This is a test message');
              },
              child: Text('Send WhatsApp Message'),
            ),
          ],
        ),
      ),
    );
  }
}
