import 'package:flutter/material.dart';
import 'package:surf/src/components/pressable.dart';

class Textinput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorText;
  final String? Function(String?)? onChanged;

  const Textinput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.errorText,
      this.onChanged});

  @override
  State<Textinput> createState() => _TextinputState();
}

class _TextinputState extends State<Textinput> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.tertiary),
      textInputAction: TextInputAction.next,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.controller.text.isNotEmpty
            ? Pressable(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                onTap: widget.controller.clear,
                child: Icon(Icons.close,
                    size: 16, color: Theme.of(context).colorScheme.tertiary),
              )
            : Container(width: 20),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        errorText: widget.errorText,
      ),
    );
  }
}
