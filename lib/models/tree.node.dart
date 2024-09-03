import 'package:mobx/mobx.dart';

class TreeNode {
  final String id;
  final String name;
  final bool isComponent;
  final String? sensorType;
  final String? status;
  ObservableList<TreeNode> children;

  TreeNode({
    required this.id,
    required this.name,
    this.isComponent = false,
    this.sensorType,
    this.status,
    List<TreeNode>? children,
  }) : children = ObservableList.of(children ?? []);
}
