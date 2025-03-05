import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.onNewItem,
    required this.onUseAssistant,
    required this.onClearAll,
  });

  final Function() onNewItem;
  final Function() onUseAssistant;
  final Function() onClearAll;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Color.fromARGB(255, 74, 55, 128),
      foregroundColor: Colors.white,
      elevation: 5.0,
      icon: Icons.add,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(
          child: Icon(Icons.delete),
          backgroundColor: const Color.fromARGB(255, 214, 135, 129),
          label: 'Clear all',
          onTap: () {
            onClearAll();
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          label: 'New Item',
          onTap: () {
            onNewItem();
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.auto_fix_high),
          backgroundColor: Colors.orange,
          label: 'Use assistant',
          onTap: () {
            onUseAssistant();
          },
        ),
      ],
    );
  }
}
