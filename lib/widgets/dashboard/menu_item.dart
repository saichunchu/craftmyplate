import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title, items;
  final bool showDivider;

  const MenuItem({
    Key? key, required this.title, required this.items,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(items),
       
      ]),
    );
  }
}
