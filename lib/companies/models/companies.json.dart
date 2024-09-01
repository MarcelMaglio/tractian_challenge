class CompaniesJson {
  String? _id;
  String? _name;

  CompaniesJson({String? id, String? name}) {
    _id = id;
    _name = name;
  }

  String? get id => _id;
  set id(String? id) => _id = id;

  String? get name => _name;
  set name(String? name) => _name = name;

  CompaniesJson.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    return data;
  }

  // Método para converter uma lista de JSON em uma lista de objetos CompaniesJson
  static List<CompaniesJson> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CompaniesJson.fromJson(json)).toList();
  }

  // Método para converter uma lista de objetos CompaniesJson em uma lista de JSON
  static List<Map<String, dynamic>> toJsonList(List<CompaniesJson> companiesList) {
    return companiesList.map((company) => company.toJson()).toList();
  }
}
