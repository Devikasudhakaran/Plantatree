import 'package:flutter/material.dart';

class ListViewBuilder extends StatelessWidget {
  int? itemCount;
  Widget? Function(BuildContext, int) itemBuilder;
  ListViewBuilder(
      {super.key, required this.itemBuilder, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
