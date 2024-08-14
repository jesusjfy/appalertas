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

  void _notifyHead(BuildContext context) async {
    try {
      await _smsService.sendSms(area.head.phoneNumber,
          'Ocurrió un error, favor de revisar su bandeja de entrada!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('SMS enviado al jefe de área: ${area.head.name}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al notificar al jefe de área: $e')),
      );
    }
  }

  void _notifyWorkers(BuildContext context) async {
    try {
      for (var worker in area.workers) {
        await _smsService.sendSms(worker.phoneNumber,
            'Ocurrió un error, favor de revisar su bandeja de entrada!');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMS enviados a los trabajadores del área')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al notificar a los trabajadores: $e')),
      );
    }
  }

  void _notifyAll(BuildContext context) async {
    try {
      await _smsService.sendSms(area.head.phoneNumber,
          'Ocurrió un error, favor de revisar su bandeja de entrada!');

      for (var worker in area.workers) {
        await _smsService.sendSms(worker.phoneNumber,
            'Ocurrió un error, favor de revisar su bandeja de entrada!');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('SMS enviados a todos en el área, incluyendo al jefe')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al notificar a todos en el área: $e')),
      );
    }
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
                            onPressed: () => _smsService.sendSms(
                                worker.phoneNumber,
                                'Ocurrió un error, favor de revisar su bandeja de entrada!'),
                            tooltip: 'Enviar SMS',
                          ),
                          IconButton(
                            icon: Icon(Icons.call),
                            onPressed: () =>
                                _callService.makePhoneCall(worker.phoneNumber),
                            tooltip: 'Llamar',
                          ),
                          IconButton(
                            icon: Icon(Icons.chat),
                            onPressed: () => _whatsappService.sendWhatsappMessage(
                                worker.whatsappNumber,
                                'Ocurrió un error, favor de revisar su bandeja de entrada!'),
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
