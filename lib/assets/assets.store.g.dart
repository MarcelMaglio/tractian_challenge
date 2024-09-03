// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on _AssetsStore, Store {
  late final _$errorAtom = Atom(name: '_AssetsStore.error', context: context);

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

  late final _$assetsListAtom =
      Atom(name: '_AssetsStore.assetsList', context: context);

  @override
  ObservableList<AssetsJson>? get assetsList {
    _$assetsListAtom.reportRead();
    return super.assetsList;
  }

  @override
  set assetsList(ObservableList<AssetsJson>? value) {
    _$assetsListAtom.reportWrite(value, super.assetsList, () {
      super.assetsList = value;
    });
  }

  late final _$getAssetsAsyncAction =
      AsyncAction('_AssetsStore.getAssets', context: context);

  @override
  Future<void> getAssets({required String id}) {
    return _$getAssetsAsyncAction.run(() => super.getAssets(id: id));
  }

  @override
  String toString() {
    return '''
error: ${error},
assetsList: ${assetsList}
    ''';
  }
}
