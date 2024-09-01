import 'package:dio/dio.dart';

import '../helpers/constantes.dart';
import '../helpers/http.dart';

class CompaniesService {
  static Future<Response> getCompanies() async {
    const url = "$URL/companies";

    return await dio.get(url);
  }
}