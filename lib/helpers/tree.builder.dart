import '../models/assets.json.dart';
import '../models/locations.json.dart';
import '../models/tree.node.dart';

class TreeBuilder {
  final List<LocationsJson> locations;
  final List<AssetsJson> assets;

  TreeBuilder({required this.locations, required this.assets});

  List<TreeNode> buildTree() {
    Map<String, TreeNode> nodeMap = {};

    // Cria nós para locais
    for (var location in locations) {
      nodeMap[location.id!] = TreeNode(
        id: location.id!,
        name: location.name!,
        isExpanded: false
      );
    }

    // Cria nós para ativos e componentes
    for (var asset in assets) {
      bool isComponent = asset.sensorType != null;
      nodeMap[asset.id!] = TreeNode(
        id: asset.id!,
        name: asset.name!,
        isComponent: isComponent,
        sensorType: asset.sensorType,
        sensorId: asset.sensorId,
        status: asset.status,
        isExpanded: false
      );
    }

    // Adiciona filhos para locais com base em parentId
    for (var location in locations) {
      if (location.parentId != null && nodeMap.containsKey(location.parentId)) {
        nodeMap[location.parentId!]!.children.add(nodeMap[location.id!]!);
      }
    }

    // Adiciona filhos para ativos com base em locationId e parentId
    for (var asset in assets) {
      if (asset.locationId != null && nodeMap.containsKey(asset.locationId)) {
        nodeMap[asset.locationId!]!.children.add(nodeMap[asset.id!]!);
      } else if (asset.parentId != null && nodeMap.containsKey(asset.parentId)) {
        nodeMap[asset.parentId!]!.children.add(nodeMap[asset.id!]!);
      }
    }

    // Encontra todos os nós que não têm pais
    Set<TreeNode> rootNodes = {};
    Set<TreeNode> allNodes = nodeMap.values.toSet();

    for (var node in allNodes) {
      bool hasParent = allNodes.any((n) => n.children.contains(node));
      if (!hasParent) {
        rootNodes.add(node);
      }
    }

    return rootNodes.toList();
  }
}
