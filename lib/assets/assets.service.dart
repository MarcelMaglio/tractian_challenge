import 'package:dio/dio.dart';

import '../helpers/constantes.dart';
import '../helpers/http.dart';

class AssetsService {
  static Future<Response> getAssets({required String id}) async {
    final url = "$URL/companies/$id/assets";

    return await dio.get(url);
  }
}