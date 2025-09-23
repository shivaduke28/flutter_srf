import 'package:flutter/material.dart';

class SortMenuItem<T> {
  final T value;
  final String label;
  final IconData? icon;

  const SortMenuItem({required this.value, required this.label, this.icon});
}

class SortPopupMenuButton<T> extends StatelessWidget {
  final T currentValue;
  final List<SortMenuItem<T>> items;
  final void Function(T) onSelected;
  final IconData icon;

  const SortPopupMenuButton({
    super.key,
    required this.currentValue,
    required this.items,
    required this.onSelected,
    this.icon = Icons.sort,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      icon: Icon(icon),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((SortMenuItem<T> item) {
          return PopupMenuItem<T>(
            value: item.value,
            child: Row(
              children: [
                if (currentValue == item.value) const Icon(Icons.check, size: 20) else const SizedBox(width: 20),
                const SizedBox(width: 8),
                if (item.icon != null) ...[Icon(item.icon, size: 20), const SizedBox(width: 8)],
                Text(item.label),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
