import 'package:flutter/material.dart';

class CategorySelectorWidget extends StatelessWidget {
  final List<String> allCategories;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  const CategorySelectorWidget({
    super.key,
    required this.allCategories,
    required this.selected,
    required this.onChanged,
  });

  void _openDialog(BuildContext context) async {
    final tempSelected = [...selected];
    final result = await showDialog<List<String>>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setStateDialog) {
            return AlertDialog(
              title: const Text("Chọn danh mục"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: allCategories.map((cat) {
                  final isSelected = tempSelected.contains(cat);
                  return CheckboxListTile(
                    title: Text(cat),
                    value: isSelected,
                    onChanged: (val) {
                      setStateDialog(() {
                        if (val == true) {
                          tempSelected.add(cat);
                        } else {
                          tempSelected.remove(cat);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
                ElevatedButton(onPressed: () => Navigator.pop(context, tempSelected), child: const Text("Xong")),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Danh mục", style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          readOnly: true,
          decoration: const InputDecoration(labelText: "Chọn danh mục"),
          onTap: () => _openDialog(context),
        ),
        Wrap(
          spacing: 8,
          children: selected.map((c) => Chip(label: Text(c))).toList(),
        )
      ],
    );
  }
}
