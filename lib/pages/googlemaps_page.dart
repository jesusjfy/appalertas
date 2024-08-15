import 'package:appalertas/models/company_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatelessWidget {
  final List<Company> companies;

  GoogleMapPage({required this.companies});

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = companies.map((company) {
      return Marker(
        markerId: MarkerId(company.name),
        position: LatLng(company.latitude, company.longitude),
        infoWindow: InfoWindow(
          title: company.name,
        ),
      );
    }).toSet();

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
        backgroundColor: Colors.blue[800],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(companies.isNotEmpty
              ? companies[0].latitude
              : 0.0,
              companies.isNotEmpty
              ? companies[0].longitude
              : 0.0),
          zoom: 4.5,
        ),
        markers: markers,
      ),
    );
  }
}
