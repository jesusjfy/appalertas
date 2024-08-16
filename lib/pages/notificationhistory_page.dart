import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de notificaciones'),
        backgroundColor: Colors.blue[800],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notification_history')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las notificaciones'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay notificaciones disponibles'));
          }

          final notifications = snapshot.data!.docs;

          final smsNotifications = notifications
              .where((notification) => notification['type'] == 'SMS')
              .toList();

          final sentSmsNotifications = smsNotifications
              .where((notification) =>
                  notification['status'] == 'Enviado' ||
                  notification['status'] == 'Success')
              .toList();
          final failedSmsNotifications = smsNotifications
              .where((notification) =>
                  notification['status'] == 'No Enviado' ||
                  notification['status'] == 'Error')
              .toList();

          return ListView(
            children: [

              if (sentSmsNotifications.isNotEmpty)
                _buildNotificationSection(
                  title: 'SMS Enviados',
                  notifications: sentSmsNotifications,
                ),
              if (failedSmsNotifications.isNotEmpty)
                _buildNotificationSection(
                  title: 'SMS No Enviados',
                  notifications: failedSmsNotifications,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotificationSection({
    required String title,
    required List<QueryDocumentSnapshot> notifications,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
        ),
        ...notifications.map((notification) {
          final timestamp = notification['timestamp'] as Timestamp;
          final formattedDate = timestamp.toDate().toLocal().toString();
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                notification['recipient'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${notification['message']}\n$formattedDate',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                notification['status'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: notification['status'] == 'Enviado' ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
