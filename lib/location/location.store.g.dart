// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationStore on _LocationStore, Store {
  late final _$errorAtom = Atom(name: '_LocationStore.error', context: context);

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

  late final _$locationListAtom =
      Atom(name: '_LocationStore.locationList', context: context);

  @override
  ObservableList<LocationsJson>? get locationList {
    _$locationListAtom.reportRead();
    return super.locationList;
  }

  @override
  set locationList(ObservableList<LocationsJson>? value) {
    _$locationListAtom.reportWrite(value, super.locationList, () {
      super.locationList = value;
    });
  }

  late final _$getLocationsAsyncAction =
      AsyncAction('_LocationStore.getLocations', context: context);

  @override
  Future<void> getLocations({required String id}) {
    return _$getLocationsAsyncAction.run(() => super.getLocations(id: id));
  }

  @override
  String toString() {
    return '''
error: ${error},
locationList: ${locationList}
    ''';
  }
}
