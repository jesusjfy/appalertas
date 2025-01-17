import 'package:appalertas/models/company_model.dart';
import 'package:appalertas/pages/googlemaps_page.dart';
import 'package:appalertas/pages/home_page.dart';
import 'package:appalertas/pages/login_page.dart';
import 'package:appalertas/pages/notificationhistory_page.dart';
import 'package:appalertas/pages/settings_page.dart';
import 'package:appalertas/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Company>> _companiesFuture;

  @override
  void initState() {
    super.initState();
    _companiesFuture = _firestoreService.getCompanies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Company>>(
      future: _companiesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        List<Company> companies = snapshot.data!;

        final List<Widget> _pages = [
          HomePage(companies: companies),
          NotificationHistoryPage(),
          GoogleMapPage(companies: companies),
          SettingsPage(),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Text('App Alertas'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: _signOut,
                tooltip: 'Cerrar Sesión',
              ),
            ],
            backgroundColor: Colors.blue[800],
          ),
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Historial',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Ubicación',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Configuración',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[800],
            unselectedItemColor: Colors.grey[600],
            backgroundColor: Colors.white,
            elevation: 10,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
