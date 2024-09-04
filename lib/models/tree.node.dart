import 'package:mobx/mobx.dart';

class TreeNode {
  final String id;
  final String name;
  final bool isComponent;
  final String? sensorType;
  final String? sensorId;
  final String? status;
  bool isExpanded;
  ObservableList<TreeNode> children;

  TreeNode({
    required this.id,
    required this.name,
    this.isComponent = false,
    this.sensorId,
    this.sensorType,
    this.status,
    this.isExpanded = false,
    List<TreeNode>? children,
  }) : children = ObservableList.of(children ?? []);
}
