import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/call_service.dart';
import '../services/notification_service.dart';
import '../services/sms_service.dart';
import '../services/whatsapp_service.dart';
import 'login_page.dart';

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
    _notificationService.showNotification('Hola ${user.name}', 'Proceso finalizado sin errores');
  }

  Future<void> sendSms(User user) async {
    await _smsService.sendSms('Hola ${user.name}', user.phoneNumber);
  }

  Future<void> makePhoneCall(User user) async {
    await _callService.makePhoneCall(user.phoneNumber);
  }

  Future<void> sendWhatsappMessage(User user) async {
    await _whatsappService.sendWhatsappMessage(user.whatsappNumber, 'Hola ${user.name}');
  }

  Future<void> _signOut(BuildContext context) async {
    await firebase_auth.FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trabajadores'),
        backgroundColor: const Color(0xffb144094),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(248, 100, 137, 209), const Color.fromARGB(250, 31, 72, 148)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  user.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  user.phoneNumber,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                trailing: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.blue),
                        onPressed: () => sendNotification(user),
                      ),
                      IconButton(
                        icon: Icon(Icons.message, color: Colors.green),
                        onPressed: () => sendSms(user),
                      ),
                      IconButton(
                        icon: Icon(Icons.call, color: Colors.orange),
                        onPressed: () => makePhoneCall(user),
                      ),
                      IconButton(
                        icon: Icon(Icons.chat, color: Colors.teal),
                        onPressed: () => sendWhatsappMessage(user),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
