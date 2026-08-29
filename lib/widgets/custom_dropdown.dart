import 'package:flutter/material.dart';

class CustomAddableDropdown extends StatefulWidget {
  final double? width;

  const CustomAddableDropdown({super.key, this.width});

  @override
  State<CustomAddableDropdown> createState() => _CustomAddableDropdownState();
}

class _CustomAddableDropdownState extends State<CustomAddableDropdown> {
  List<String> items = [
    'Chest',
    'Back',
    'Legs',
    'Shoulders',
    'Biceps',
    'Triceps',
  ];
  String? selectedItem;
  final TextEditingController textController = TextEditingController();

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Item"),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: "Enter name..."),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  setState(() {
                    items.add(textController.text);
                    selectedItem = textController.text;
                    textController.clear();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: widget.width,
      menuHeight: 200,
      label: Text("Muscle group"),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      initialSelection: selectedItem,
      dropdownMenuEntries: [
        for (String item in items) DropdownMenuEntry(value: item, label: item),
        const DropdownMenuEntry(value: 'add_new', label: '+ Add new'),
      ],
      onSelected: (String? value) {
        if (value == 'add_new') {
          _showAddDialog();
        } else {
          setState(() {
            selectedItem = value;
          });
        }
      },
    );
  }
}
