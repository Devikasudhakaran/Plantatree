import 'package:flutter/cupertino.dart';

class GridviewBuilder extends StatelessWidget {
  final int itemCount;
  final List<dynamic> dataList;
  final BuildContext context;
  final Widget? Function(BuildContext, int) itemBuilder;

  const GridviewBuilder({
    super.key,
    required this.itemBuilder,
    required this.context,
    required this.dataList,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
