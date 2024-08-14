import 'package:appalertas/models/area_model.dart';
import 'package:appalertas/models/company_model.dart';
import 'package:appalertas/models/user_model.dart';
import 'package:appalertas/pages/area_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Company> companies = [
    Company(name: 'Empresa A', areas: [
      Area(name: 'Área 1', head: 'Jefe A1', workers: [
        User(name: 'Trabajador 1', phoneNumber: '', whatsappNumber: '', position: 'Posición 1'),
        User(name: 'Trabajador 2', phoneNumber: '', whatsappNumber: '', position: 'Posición 2'),
      ]),
      Area(name: 'Área 2', head: 'Jefe A2', workers: [
        User(name: 'Trabajador 3', phoneNumber: '', whatsappNumber: '', position: 'Posición 3'),
        User(name: 'Trabajador 4', phoneNumber: '', whatsappNumber: '', position: 'Posición 4'),
      ]),
    ]),
    Company(name: 'Empresa B', areas: [
      Area(name: 'Área 3', head: 'Jefe B1', workers: [
        User(name: 'Trabajador 5', phoneNumber: '', whatsappNumber: '', position: 'Posición 5'),
        User(name: 'Trabajador 6', phoneNumber: '', whatsappNumber: '', position: 'Posición 6'),
      ]),
      Area(name: 'Área 4', head: 'Jefe B2', workers: [
        User(name: 'Trabajador 7', phoneNumber: '', whatsappNumber: '', position: 'Posición 7'),
        User(name: 'Trabajador 8', phoneNumber: '', whatsappNumber: '', position: 'Posición 8'),
      ]),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empresas'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Selecciona una empresa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        company.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue[800]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AreaPage(company: company),
                          ),
                        );
                      },
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
