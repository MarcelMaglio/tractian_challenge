import 'package:mobx/mobx.dart';
import 'package:tractian_challenge/models/assets.json.dart';

import 'assets.service.dart';

part 'assets.store.g.dart';

class AssetsStore = _AssetsStore with _$AssetsStore;

abstract class _AssetsStore with Store {

  @observable
  Exception? error;

  @observable
  ObservableList<AssetsJson>? assetsList = <AssetsJson>[].asObservable();

  @action
  Future<void> getAssets({required String id}) async {
    try {
      error = null;
      assetsList = null;
      final response = await AssetsService.getAssets(id: id);
      if (response.statusCode == 200) {
        final mapAssets = AssetsJson.fromJsonList(response.data);
        assetsList = mapAssets.asObservable();
      }
    } catch (e) {
      error = e as Exception?;
    }
  }
}