import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditTemplatePage extends StatefulWidget {
  final String templateId;
  final String title;
  final String body;

  EditTemplatePage(
      {required this.templateId, required this.title, required this.body});

  @override
  _EditTemplatePageState createState() => _EditTemplatePageState();
}

class _EditTemplatePageState extends State<EditTemplatePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _bodyController.text = widget.body;
  }

  Future<void> _updateTemplate() async {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos.')),
      );
      return;
    }

    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar'),
        content: Text('¿Desea guardar los cambios?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Guardar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _firestore.collection('notification_templates').doc(widget.templateId).update({
          'title': _titleController.text,
          'body': _bodyController.text,
          'updated_at': Timestamp.now(),
        });
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el template: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Mensaje'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              maxLength: 30,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Cuerpo del Mensaje'),
              maxLength: 80,
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateTemplate,
              child: Text('Guardar Cambios'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
