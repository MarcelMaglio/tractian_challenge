// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CompaniesStore on _CompaniesStore, Store {
  late final _$errorAtom =
      Atom(name: '_CompaniesStore.error', context: context);

  @override
  Exception? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$companiesListAtom =
      Atom(name: '_CompaniesStore.companiesList', context: context);

  @override
  ObservableList<CompaniesJson>? get companiesList {
    _$companiesListAtom.reportRead();
    return super.companiesList;
  }

  @override
  set companiesList(ObservableList<CompaniesJson>? value) {
    _$companiesListAtom.reportWrite(value, super.companiesList, () {
      super.companiesList = value;
    });
  }

  late final _$getCompaniesAsyncAction =
      AsyncAction('_CompaniesStore.getCompanies', context: context);

  @override
  Future<void> getCompanies() {
    return _$getCompaniesAsyncAction.run(() => super.getCompanies());
  }

  @override
  String toString() {
    return '''
error: ${error},
companiesList: ${companiesList}
    ''';
  }
}
