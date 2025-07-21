import 'package:craftmyplate/widgets/approval/approval_status_item.dart';
import 'package:flutter/material.dart';
import '../../screens/approval_screen.dart';

class ApprovalStatusList extends StatelessWidget {
  final List<ApprovalItem> items;


  const ApprovalStatusList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ApprovalListItem(item: items[index]);
      },
    );
  }
}
