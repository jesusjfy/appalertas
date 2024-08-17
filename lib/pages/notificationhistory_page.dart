import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationHistoryPage extends StatefulWidget {
  @override
  _NotificationHistoryPageState createState() =>
      _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de notificaciones'),
        backgroundColor: Colors.blue[800],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Enviados'),
            Tab(text: 'No Enviados'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList('Enviado'),
          _buildNotificationList('Error'),
        ],
      ),
    );
  }

  Widget _buildNotificationList(String status) {
    return StreamBuilder<QuerySnapshot>(
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

        final notifications = snapshot.data!.docs
            .where((doc) => doc['status'] == status)
            .toList();

        if (notifications.isEmpty) {
          return Center(
              child: Text('No hay notificaciones $status disponibles'));
        }

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
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
                trailing: Icon(
                  status == 'Enviado' ? Icons.check_circle : Icons.error,
                  color: status == 'Enviado' ? Colors.green : Colors.red,
                  size: 24.0,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
