import 'package:flutter/material.dart';

class CustomAddableDropdown extends StatefulWidget {
  final double? width;
  final String label;
  final List<String> items;
  final String? initialValue;
  final bool allowAddNew; 
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String>? onItemAdded;

  const CustomAddableDropdown({
    super.key,
    required this.label,
    required this.items,
    this.initialValue,
    this.width,
    this.allowAddNew = true, 
    this.onChanged,
    this.onItemAdded,
  });

  @override
  State<CustomAddableDropdown> createState() => _CustomAddableDropdownState();
}

class _CustomAddableDropdownState extends State<CustomAddableDropdown> {
  String? selectedItem;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue;
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New ${widget.label}"),
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
                  final newItem = textController.text.trim();
                  widget.onItemAdded?.call(newItem);
                  setState(() {
                    selectedItem = newItem;
                  });
                  widget.onChanged?.call(newItem);
                  textController.clear();
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
      label: Text(widget.label),
      initialSelection: selectedItem,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      dropdownMenuEntries: [
        for (String item in widget.items)
          DropdownMenuEntry(value: item, label: item),
       
        if (widget.allowAddNew)
          const DropdownMenuEntry(value: 'add_new', label: '+ Add new'),
      ],
      onSelected: (String? value) {
        if (value == 'add_new') {
          _showAddDialog();
        } else {
          setState(() {
            selectedItem = value;
          });
          widget.onChanged?.call(value);
        }
      },
    );
  }
}
