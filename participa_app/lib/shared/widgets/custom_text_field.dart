import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool enabled;
  final void Function(String)? onChanged;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,
    this.validator,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.enabled = true,
    this.onChanged,
    this.fillColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;
  // ignore: unused_field
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  OutlineInputBorder _baseBorder(Color color, double radius) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(radius),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = widget.fillColor ?? const Color.fromARGB(143, 14, 124, 87);

    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      validator: (v) {
        final res = widget.validator?.call(v);
        setState(() {
          _hasError = res != null;
        });
        return res;
      },
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: theme.colorScheme.inversePrimary,
          fontWeight: FontWeight.w400,
        ),

        filled: true,
        fillColor: bgColor,

        enabledBorder: _baseBorder(Colors.transparent, 10),
        focusedBorder: _baseBorder(Colors.transparent, 5),
        disabledBorder: _baseBorder(Colors.transparent, 10),

        errorBorder: _baseBorder(Colors.red.shade700, 10),
        focusedErrorBorder: _baseBorder(Colors.red.shade700, 10),

        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8, right: 6),
                child: Icon(
                  widget.icon,
                  color: theme.colorScheme.inversePrimary,
                ),
              )
            : null,

        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: theme.colorScheme.inversePrimary,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,

        counterText: widget.maxLength != null ? '' : null,
      ),
      style: TextStyle(color: theme.colorScheme.onSurface),
    );
  }
}
