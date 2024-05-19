import 'package:flutter/material.dart';

class ButtonsToggle extends StatelessWidget {
  final void Function(int value) onTap;
  final int value;
  final List<int> options;

  const ButtonsToggle({
    super.key,
    required this.onTap,
    required this.value,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        onTap(options[index]);
      },
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      borderColor: Theme.of(context).colorScheme.onPrimary,
      selectedBorderColor: Theme.of(context).colorScheme.secondary,
      selectedColor: Theme.of(context).colorScheme.primary,
      fillColor: Theme.of(context).colorScheme.secondary,
      color: Theme.of(context).colorScheme.secondary,
      constraints: const BoxConstraints(
        minHeight: 48.0,
        minWidth: 48.0,
      ),
      isSelected: options.map((option) => option == value).toList(),
      children: List.generate(
        options.length,
        (index) => Text(
          options[index].toString(),
          style: const TextStyle(
            fontFamily: 'NoyhR-Regular',
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
