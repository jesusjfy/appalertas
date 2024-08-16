import 'package:appalertas/models/company_model.dart';
import 'package:appalertas/pages/area_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Company> companies;

  HomePage({required this.companies});

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
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Colors.blue[800]),
                      onTap: () {
                        print('Áreas de la empresa seleccionada: ${company.areas}');
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