class AssetsJson {
  String? id;
  String? locationId;
  String? name;
  String? parentId;
  String? sensorType;
  String? status;

  AssetsJson(
      {this.id,
        this.locationId,
        this.name,
        this.parentId,
        this.sensorType,
        this.status});

  AssetsJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['locationId'];
    name = json['name'];
    parentId = json['parentId'];
    sensorType = json['sensorType'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['locationId'] = this.locationId;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['sensorType'] = this.sensorType;
    data['status'] = this.status;
    return data;
  }

  // Método para converter uma lista de JSON em uma lista de objetos
  static List<AssetsJson> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AssetsJson.fromJson(json)).toList();
  }

  // Método para converter uma lista de objetos em uma lista de JSON
  static List<Map<String, dynamic>> toJsonList(List<AssetsJson> companiesList) {
    return companiesList.map((company) => company.toJson()).toList();
  }
}