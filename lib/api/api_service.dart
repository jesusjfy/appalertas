import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> getData() async {
    try {
      final response = await _dio.get('https://yourapiendpoint.com/getData');
      // Procesar la respuesta
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendData(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('https://yourapiendpoint.com/sendData', data: data);
      // Procesar la respuesta
    } catch (e) {
      print(e);
    }
  }
}
