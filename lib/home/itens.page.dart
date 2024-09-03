import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tractian_challenge/assets/assets.store.dart';
import 'package:tractian_challenge/home/treeview.dart';

import '../helpers/size_config.dart';
import '../helpers/tree.builder.dart';
import '../location/location.store.dart';
import '../models/tree.node.dart';

class ItensPage extends StatefulWidget {
  final String id;

  const ItensPage({super.key, required this.id});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {

  final assetsStore = AssetsStore();
  final locationStore = LocationStore();
  List<TreeNode>? nodeTree;

  @override
  void initState() {
    _inicializarComponentes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_){
      if (assetsStore.assetsList != null && locationStore.locationList != null) {
        nodeTree ??= TreeBuilder(
            locations: locationStore.locationList!,
            assets: assetsStore.assetsList!,
          ).buildTree();

        // return CustomScrollView(
        //   slivers: [
        //     const SliverAppBar(title: Text('aaa')),
        //
        //     TreeSliver(node: nodeTree!),
        //   ],
        // );
      }

          return Center(
            child: SpinKitWave(
              color: const Color(0xFF141C2C),
              size: SizeConfig.of(context).dynamicScaleSize(size: 33),
            ),
          );
        },
      ),
    );
  }

  _inicializarComponentes() async {
    await Future.wait([
      assetsStore.getAssets(id: widget.id),
      locationStore.getLocations(id: widget.id),
    ]);
  }
}
