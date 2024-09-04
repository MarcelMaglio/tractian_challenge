import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tractian_challenge/assets/assets.store.dart';

import '../helpers/size_config.dart';
import '../helpers/tree.builder.dart';
import '../location/location.store.dart';
import '../models/tree.node.dart';

class ItensPage extends StatefulWidget {
  final String id;
  final String nomeEmpresa;

  const ItensPage({super.key, required this.id, required this.nomeEmpresa});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  final assetsStore = AssetsStore();
  final locationStore = LocationStore();
  List<TreeNode>? nodeTree;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _inicializarComponentes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nomeEmpresa,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF141C2C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: buildItens(context),
    );
  }

  Observer buildItens(BuildContext context) {
    return Observer(
      builder: (_) {
        if (assetsStore.assetsList != null &&
            locationStore.locationList != null) {
          nodeTree ??= TreeBuilder(
            locations: locationStore.locationList!,
            assets: assetsStore.assetsList!,
          ).buildTree();

          List<TreeNode> listaFiltrada =
              _filtrarNode(nodeTree!, _textController.text);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildPesquisa(),
              buildBotoes(),
              buildExpandedCustomScrollView(listaFiltrada),
            ],
          );
        }

        return Center(
          child: SpinKitWave(
            color: const Color(0xFF141C2C),
            size: SizeConfig.of(context).dynamicScaleSize(size: 33),
          ),
        );
      },
    );
  }

  Expanded buildExpandedCustomScrollView(List<TreeNode> listaFiltrada) {
    return Expanded(
      child: CustomScrollView(shrinkWrap: true, slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final node = listaFiltrada[index];
              return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          SizeConfig.of(context).dynamicScaleSize(size: 16)),
                  child: _buildTreeNode(context, node));
            },
            childCount: listaFiltrada.length,
          ),
        )
      ]),
    );
  }

  _inicializarComponentes() async {
    await Future.wait([
      assetsStore.getAssets(id: widget.id),
      locationStore.getLocations(id: widget.id),
    ]);
  }

  buildBotoes() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(MdiIcons.lightningBolt),
          label: const Text('Sensor de Energia'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            //minimumSize: Size(double.infinity, 48),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(MdiIcons.alertCircleOutline, size: 24),
          label: const Text('Crítico'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }

  buildPesquisa() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.of(context).dynamicScaleSize(size: 10),
        bottom: SizeConfig.of(context).dynamicScaleSize(size: 10),
      ),
      child: Card(
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(
              SizeConfig.of(context).dynamicScaleSize(size: 10),
            )),
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.of(context).dynamicScaleSize(size: 16),
            ),
            controller: _textController,
            onChanged: (query) {
              setState(() {});
            },
            decoration: new InputDecoration(
              hintText: 'Buscar Ativo ou local',
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: Colors.black,
              prefixIcon: Icon(
                Icons.search,
                color: const Color(0xFF141C2C),
                size: SizeConfig.of(context).dynamicScaleSize(size: 30),
              ),
              suffixIcon: InkWell(
                onTap: () {
                  HapticFeedback.vibrate();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _textController.clear();
                    });
                  });
                },
                child: Visibility(
                  //visible: _textController.text.isNotEmpty,
                  child: Icon(
                    Icons.cancel,
                    color: const Color(0xFF141C2C),
                    size: SizeConfig.of(context).dynamicScaleSize(size: 25),
                  ),
                ),
              ),
              contentPadding: EdgeInsets.all(
                SizeConfig.of(context).dynamicScaleSize(size: 10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  SizeConfig.of(context).dynamicScaleSize(size: 10),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.surface,
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.of(context).dynamicScaleSize(size: 10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: const Color(0xFF141C2C),
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.of(context).dynamicScaleSize(size: 10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTreeNode(BuildContext context, TreeNode node, {int level = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: 14.0 * level),
      child: node.children.isEmpty
          ? ListTile(
              leading: _getLeadingIcon(node),
              title: Text(node.name),
              contentPadding: EdgeInsets.zero,
            )
          : Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: _getLeadingIcon(node),
                title: Text(node.name),
                trailing: node.children.isEmpty
                    ? null
                    : const Icon(Icons.arrow_drop_down),
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                children: node.children
                    .map((child) =>
                        _buildTreeNode(context, child, level: level + 1))
                    .toList(),
              ),
            ),
    );
  }

  Widget _getLeadingIcon(TreeNode node) {
    return Image.asset(
      node.sensorType != null
          ? 'assets/icones/component.png'
          : node.sensorId != null || node.children.isNotEmpty
              ? 'assets/icones/asset.png'
              : 'assets/icones/location.png',
      color: Colors.blue,
    );
  }

  List<TreeNode> _filtrarNode(List<TreeNode> nodes, String query) {
    final queryLower = query.toLowerCase();

    List<TreeNode> filteredNodes = [];

    for (var node in nodes) {
      if (_encontrouNode(node, queryLower)) {
        filteredNodes.add(node);
      }
    }

    return filteredNodes;
  }

  bool _encontrouNode(TreeNode node, String query) {
    if (node.name.toLowerCase().contains(query)) {
      return true;
    }

    for (var child in node.children) {
      if (_encontrouNode(child, query)) {
        return true;
      }
    }

    return false;
  }
}
