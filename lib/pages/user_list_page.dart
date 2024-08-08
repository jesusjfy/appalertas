import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/call_service.dart';
import '../services/notification_service.dart';
import '../services/sms_service.dart';
import '../services/whatsapp_service.dart';

class UserListPage extends StatelessWidget {
  final List<User> users = [
    User(name: 'John Doe', phoneNumber: '+15551234567', whatsappNumber: '+15551234567'),
    User(name: 'Jane Smith', phoneNumber: '+15557654321', whatsappNumber: '+15557654321'),
    User(name: 'Juan Flores', phoneNumber: '+15557654322', whatsappNumber: '+15557654322'),
    User(name: 'Pedro la Rosa', phoneNumber: '+15557654323', whatsappNumber: '+15557654323'),
    User(name: 'Luz Quispe', phoneNumber: '+15557654324', whatsappNumber: '+15557654324'),
    User(name: 'Luis Carbajal', phoneNumber: '+15557654325', whatsappNumber: '+15557654325'),
    User(name: 'Ximena Santos', phoneNumber: '+15557654326', whatsappNumber: '+15557654326'),
    User(name: 'Maria del Campo', phoneNumber: '+15557654327', whatsappNumber: '+15557654327'),
    User(name: 'Elvis Choque', phoneNumber: '+15557654328', whatsappNumber: '+15557654328'),
    User(name: 'Wilber Pongo', phoneNumber: '+15557654329', whatsappNumber: '+15557654329'),
  ];

  final CallService _callService = CallService();
  final NotificationService _notificationService = NotificationService();
  final SmsService _smsService = SmsService();
  final WhatsappService _whatsappService = WhatsappService();

  void sendNotification(User user) {
    _notificationService.showNotification('Hello ${user.name}', 'Proceso finalizado sin errores');
  }

  Future<void> sendSms(User user) async {
    await _smsService.sendSms('Hello ${user.name}', user.phoneNumber);
  }

  Future<void> makePhoneCall(User user) async {
    await _callService.makePhoneCall(user.phoneNumber);
  }

  Future<void> sendWhatsappMessage(User user) async {
    await _whatsappService.sendWhatsappMessage(user.whatsappNumber, 'Hello ${user.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de usuarios'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.phoneNumber),
            trailing: SizedBox(
              width: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () => sendNotification(user),
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () => sendSms(user),
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () => makePhoneCall(user),
                  ),
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () => sendWhatsappMessage(user),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
