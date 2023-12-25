import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String? initialSelection;
  final List<String> menuEntries;
  final Function(String?) onSelected;

  const CustomDropdownMenu({
    required this.initialSelection,
    required this.menuEntries,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 2),borderRadius:BorderRadius.circular(20),),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: SizedBox(),
        
        padding: EdgeInsets.symmetric(horizontal: 20),
        value: initialSelection,
        onChanged: onSelected,
        items: menuEntries.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
