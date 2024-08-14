import 'package:flutter/material.dart';

import '../models/area_model.dart';

class WorkersPage extends StatelessWidget {
  final Area area;

  WorkersPage({required this.area});

  void _notifyHead(BuildContext context) {
    // Implementa la lógica para notificar al jefe del área
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notificando al jefe de área: ${area.head}')),
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
            onSelected: (value) {
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
                      title: Text(
                        worker.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
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