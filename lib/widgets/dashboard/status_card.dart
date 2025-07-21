import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final Animation<double> animation;
  final int index;

  const StatusCard({
    Key? key,
    required this.title,
    required this.count,
    required this.color,
    required this.animation,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Transform.translate(
          offset: Offset(0, (1 - animation.value) * (50 * (index + 1))),
          child: Opacity(opacity: animation.value, child: buildCard(context)),
        );
      },
    );
  }

  Widget buildCard(BuildContext ctx) => Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Spacer(),
        Row(
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Spacer(),
          ],
        ),
      ],
    ),
  );
}
