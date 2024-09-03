import 'package:flutter/material.dart';

import '../models/tree.node.dart';

class TreeSliver extends StatelessWidget {
  final TreeNode node;

  const TreeSliver({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final childNode = node.children[index];
          return _buildTreeNode(context, childNode);
        },
        childCount: node.children.length,
      ),
    );
  }

  Widget _buildTreeNode(BuildContext context, TreeNode node) {
    return ExpansionTile(
      leading: _getLeadingIcon(node),
      title: Text(node.name),
      children: node.children.isNotEmpty
          ? node.children.map((child) => _buildTreeNode(context, child)).toList()
          : [],
    );
  }

  Widget _getLeadingIcon(TreeNode node) {
    return Icon(
      node.sensorType != null ? Icons.device_hub : Icons.location_on,
      color: Colors.blue,
    );
  }
}
