import 'package:flutter/material.dart';

class NationSelectorWidget extends StatelessWidget {
  final List<String> nations;
  final String selected;
  final ValueChanged<String> onChanged;

  const NationSelectorWidget({
    super.key,
    required this.nations,
    required this.selected,
    required this.onChanged,
  });

  void _openDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text("Chọn quốc gia"),
          children: nations.map((nation) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, nation),
              child: Text(nation),
            );
          }).toList(),
        );
      },
    );

    if (result != null) {
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: selected),
      onTap: () => _openDialog(context),
      decoration: const InputDecoration(labelText: "Quốc gia"),
    );
  }
}
