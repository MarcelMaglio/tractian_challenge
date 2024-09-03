import 'package:mobx/mobx.dart';
import 'package:tractian_challenge/models/locations.json.dart';

import 'location.service.dart';

part 'location.store.g.dart';

class LocationStore = _LocationStore with _$LocationStore;

abstract class _LocationStore with Store {

  @observable
  Exception? error;

  @observable
  ObservableList<LocationsJson>? locationList = <LocationsJson>[].asObservable();

  @action
  Future<void> getLocations({required String id}) async {
    try {
      error = null;
      locationList = null;
      final response = await LocationService.getLocations(id: id);
      if (response.statusCode == 200) {
        final mapLocations = LocationsJson.fromJsonList(response.data);
        locationList = mapLocations.asObservable();
      }
    } catch (e) {
      error = e as Exception?;
    }
  }
}