class LocationsJson {
  String? id;
  String? name;
  String? parentId;

  LocationsJson({this.id, this.name, this.parentId});

  LocationsJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    return data;
  }

  // Método para converter uma lista de JSON em uma lista de objetos
  static List<LocationsJson> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LocationsJson.fromJson(json)).toList();
  }

  // Método para converter uma lista de objetos em uma lista de JSON
  static List<Map<String, dynamic>> toJsonList(List<LocationsJson> companiesList) {
    return companiesList.map((company) => company.toJson()).toList();
  }
}