import 'package:appalertas/models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Company>> getCompanies() async {
    try {
      CollectionReference companiesCollection = _db.collection('companies');
      QuerySnapshot querySnapshot = await companiesCollection.get();

      List<Company> companies = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        QuerySnapshot areasSnapshot =
            await doc.reference.collection('areas').get();
        List<Map<String, dynamic>> areas = areasSnapshot.docs
            .map((areaDoc) => areaDoc.data() as Map<String, dynamic>)
            .toList();

        companies.add(Company.fromFirestore(data, areas));
      }

      return companies;
    } catch (e) {
      print('Error fetching companies: $e');
      return [];
    }
  }

  Future<void> addCompanies() async {
    CollectionReference companies = _db.collection('companies');

    await companies.doc('empresaTacna').set({
      'name': 'Empresa Tacna',
      'latitude': -18.0146,
      'longitude': -70.2526,
    });
    await _addAreas(companies.doc('empresaTacna').collection('areas'), [
      {
        'name': 'Área 1',
        'head': {
          'name': 'Jefe A1',
          'phoneNumber': '+15551234567',
          'whatsappNumber': '+15551234567',
          'position': 'Posición 1',
        },
        'workers': [
          {
            'name': 'Trabajador 1',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 1',
          },
          {
            'name': 'Trabajador 2',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 2',
          },
        ],
      },
      {
        'name': 'Área 2',
        'head': {
          'name': 'Jefe A2',
          'phoneNumber': '+15551234567',
          'whatsappNumber': '+15551234567',
          'position': 'Posición 1',
        },
        'workers': [
          {
            'name': 'Trabajador 3',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 3',
          },
          {
            'name': 'Trabajador 4',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 4',
          },
        ],
      },
    ]);

    await companies.doc('empresaArequipa').set({
      'name': 'Empresa Arequipa',
      'latitude': -16.4090,
      'longitude': -71.5376,
    });
    await _addAreas(companies.doc('empresaArequipa').collection('areas'), [
      {
        'name': 'Área 3',
        'head': {
          'name': 'Jefe B1',
          'phoneNumber': '+15551234567',
          'whatsappNumber': '+15551234567',
          'position': 'Posición 1',
        },
        'workers': [
          {
            'name': 'Trabajador 5',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 5',
          },
          {
            'name': 'Trabajador 6',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 6',
          },
        ],
      },
      {
        'name': 'Área 4',
        'head': {
          'name': 'Jefe B2',
          'phoneNumber': '+15551234567',
          'whatsappNumber': '+15551234567',
          'position': 'Posición 1',
        },
        'workers': [
          {
            'name': 'Trabajador 7',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 7',
          },
          {
            'name': 'Trabajador 8',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 8',
          },
        ],
      },
    ]);

    await companies.doc('empresaTrujillo').set({
      'name': 'Empresa Trujillo',
      'latitude': -8.1082,
      'longitude': -79.0282,
    });
    await _addAreas(companies.doc('empresaTrujillo').collection('areas'), [
      {
        'name': 'Área 5',
        'head': {
          'name': 'Jefe C1',
          'phoneNumber': '+15551234567',
          'whatsappNumber': '+15551234567',
          'position': 'Posición 1',
        },
        'workers': [
          {
            'name': 'Trabajador 9',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 9',
          },
          {
            'name': 'Trabajador 10',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 10',
          },
        ],
      },
    ]);

    await companies.doc('empresaLima').set({
      'name': 'Empresa Lima',
      'latitude': -12.0464,
      'longitude': -77.0428,
    });
    await _addAreas(companies.doc('empresaLima').collection('areas'), [
      {
        'name': 'Área 6',
        'head': {
          'name': 'Jefe D1',
          'phoneNumber': '+15551234567',
          'whatsappNumber': '+15551234567',
          'position': 'Posición 1',
        },
        'workers': [
          {
            'name': 'Trabajador 11',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 11',
          },
          {
            'name': 'Trabajador 12',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 12',
          },
        ],
      },
    ]);

    await companies.doc('empresaCuzco').set({
      'name': 'Empresa Cuzco',
      'latitude': -13.5320,
      'longitude': -71.9675,
    });
    await _addAreas(companies.doc('empresaCuzco').collection('areas'), [
      {
        'name': 'Área 7',
        'head': {
          'name': 'Jefe E1',
          'phoneNumber': '+15551234567',
          'whatsappNumber': '+15551234567',
          'position': 'Posición 1',
        },
        'workers': [
          {
            'name': 'Trabajador 13',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 13',
          },
          {
            'name': 'Trabajador 14',
            'phoneNumber': '+15551234567',
            'whatsappNumber': '+15551234567',
            'position': 'Posición 14',
          },
        ],
      },
    ]);
  }

  Future<void> _addAreas(
      CollectionReference areas, List<Map<String, dynamic>> areaList) async {
    for (var area in areaList) {
      await areas.add(area);
    }
  }
}
