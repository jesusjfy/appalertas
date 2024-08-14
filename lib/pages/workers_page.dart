import 'package:flutter/material.dart';

import '../models/area_model.dart';
import '../services/call_service.dart';
import '../services/sms_service.dart';
import '../services/whatsapp_service.dart';

class WorkersPage extends StatelessWidget {
  final Area area;

  WorkersPage({required this.area});

  final CallService _callService = CallService();
  final SmsService _smsService = SmsService();
  final WhatsappService _whatsappService = WhatsappService();

  void _sendSms(String phoneNumber) async {
    await _smsService.sendSms('Ocurrió un error, favor de revisar su bandeja de entrada!', phoneNumber);
  }

  void _makePhoneCall(String phoneNumber) async {
    await _callService.makePhoneCall(phoneNumber);
  }

  void _sendWhatsappMessage(String whatsappNumber) async {
    await _whatsappService.sendWhatsappMessage(whatsappNumber, 'Ocurrió un error, favor de revisar su bandeja de entrada!');
  }

  void _notifyHead(BuildContext context) async{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notificando al jefe de área: ${area.head.name}')),
    );
  }

  void _notifyWorkers(BuildContext context) {
    // Implementa la lógica para notificar a los trabajadores
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notificando a los trabajadores del área')),
    );
  }

  void _notifyAll(BuildContext context) {
    // Implementa la lógica para notificar a todos los miembros del área, incluyendo al jefe
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notificando a todos en el área, incluyendo al jefe')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trabajadores de ${area.name}'),
        backgroundColor: Colors.blue[800],
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'Notify Head':
                  _notifyHead(context);
                  break;
                case 'Notify Workers':
                  _notifyWorkers(context);
                  break;
                case 'Notify All':
                  _notifyAll(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Notify Head',
                  child: Text('Notificar al jefe de área'),
                ),
                PopupMenuItem(
                  value: 'Notify Workers',
                  child: Text('Notificar a los trabajadores'),
                ),
                PopupMenuItem(
                  value: 'Notify All',
                  child: Text('Notificar a todos en el área'),
                ),
              ];
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lista de Trabajadores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: area.workers.length,
                itemBuilder: (context, index) {
                  final worker = area.workers[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        worker.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      subtitle: Text(
                        worker.position,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[600],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () => _sendSms(worker.phoneNumber),
                            tooltip: 'Enviar SMS',
                          ),
                          IconButton(
                            icon: Icon(Icons.call),
                            onPressed: () => _makePhoneCall(worker.phoneNumber),
                            tooltip: 'Llamar',
                          ),
                          IconButton(
                            icon: Icon(Icons.chat),
                            onPressed: () => _sendWhatsappMessage(worker.whatsappNumber),
                            tooltip: 'WhatsApp',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
