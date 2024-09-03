import 'package:mobx/mobx.dart';
import 'package:tractian_challenge/models/companies.json.dart';

import 'companies.service.dart';

part 'companies.store.g.dart';

class CompaniesStore = _CompaniesStore with _$CompaniesStore;

abstract class _CompaniesStore with Store {

  @observable
  Exception? error;

  @observable
  ObservableList<CompaniesJson>? companiesList = <CompaniesJson>[].asObservable();

  @action
  Future<void> getCompanies() async {
    try {
      error = null;
      companiesList = null;
      final response = await CompaniesService.getCompanies();
      if (response.statusCode == 200) {
        final mapCompanies = CompaniesJson.fromJsonList(response.data);
        companiesList = mapCompanies.asObservable();
      }
    } catch (e) {
      error = e as Exception?;
    }
  }
}