import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final TextInputType inputType;
  final bool enabled;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  const Textfield({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,
    required this.inputType,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.suffixIcon,
    this.validator,
    this.enabled = true,
  });

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  late bool _isObscure;
  bool _hasError = false;
  String? _errorText;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && widget.validator != null) {
        _validateField(widget.controller?.text ?? '');
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _validateField(String value) {
    if (widget.validator != null) {
      final error = widget.validator!(value);
      setState(() {
        _hasError = error != null;
        _errorText = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    Widget? effectiveSuffix;
    if (widget.obscureText) {
      effectiveSuffix = IconButton(
        icon: Icon(
          _isObscure ? Icons.visibility_off : Icons.visibility,
          color: _hasError
              ? cs.error
              : (!widget.enabled
                    ? cs.onSurface.withOpacity(0.3)
                    : cs.onSurface.withOpacity(0.6)),
          size: 20,
        ),
        onPressed: widget.enabled
            ? () => setState(() => _isObscure = !_isObscure)
            : null,
      );
    } else {
      effectiveSuffix = widget.suffixIcon;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                if (_focusNode.hasFocus && widget.enabled)
                  BoxShadow(
                    color: _hasError
                        ? cs.error.withOpacity(0.3)
                        : cs.primary.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 0.5,
                  ),
              ],
            ),
            child: TextFormField(
              focusNode: _focusNode,
              keyboardType: widget.inputType,
              textInputAction: widget.textInputAction,
              controller: widget.controller,
              obscureText: _isObscure,
              onChanged: widget.enabled
                  ? (value) {
                      widget.onChanged?.call(value);

                      if (_hasError && value.isNotEmpty) {
                        setState(() {
                          _hasError = false;
                          _errorText = null;
                        });
                      }
                    }
                  : null,
              onFieldSubmitted: widget.enabled ? widget.onSubmitted : null,
              validator: widget.validator,
              onTapOutside: widget.enabled
                  ? (_) => FocusScope.of(context).unfocus()
                  : null,
              enabled: widget.enabled,
              style: TextStyle(
                color: widget.enabled
                    ? cs.onSurface
                    : cs.onSurface.withOpacity(0.5),
              ),
              decoration: InputDecoration(
                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: _hasError
                            ? cs.error
                            : (!widget.enabled
                                  ? cs.onSurface.withOpacity(0.3)
                                  : (_focusNode.hasFocus
                                        ? cs.primary
                                        : cs.onSurface.withOpacity(0.6))),
                      )
                    : null,
                suffixIcon: effectiveSuffix,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _hasError
                        ? cs.error
                        : (!widget.enabled
                              ? Colors.transparent
                              : Colors.transparent),
                    width: _hasError ? 1.5 : 0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: widget.enabled
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _hasError ? cs.error : cs.primary,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cs.error, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cs.error, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: widget.enabled
                    ? (_hasError
                          ? cs.error.withOpacity(0.05)
                          : (_focusNode.hasFocus
                                ? cs.primaryContainer.withOpacity(0.3)
                                : const Color.fromARGB(143, 14, 124, 87)))
                    : cs.surfaceVariant.withOpacity(0.5),
                filled: true,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: cs.onSurface.withOpacity(0.5)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          if (_hasError && _errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                _errorText!,
                style: TextStyle(color: cs.error, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
