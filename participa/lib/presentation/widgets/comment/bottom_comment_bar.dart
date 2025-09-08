import 'package:flutter/material.dart';
import 'package:participa/presentation/widgets/textField/textfield.dart';

class BottomCommentBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const BottomCommentBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom > 0
              ? MediaQuery.of(context).padding.bottom
              : 12,
          top: 8,
        ),
        child: SizedBox(
          height: 64,
          child: Center(
            child: Textfield(
              controller: controller,
              hintText: 'Escreva seu comentario',
              obscureText: false,
              icon: null,
              inputType: TextInputType.text,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              suffixIcon: Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.18),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onSend,
                  icon: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  splashRadius: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
