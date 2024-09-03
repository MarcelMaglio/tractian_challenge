import 'package:dio/dio.dart';

import '../helpers/constantes.dart';
import '../helpers/http.dart';

class LocationService {
  static Future<Response> getLocations({required String id}) async {
    final url = "$URL/companies/$id/locations";

    return await dio.get(url);
  }
}