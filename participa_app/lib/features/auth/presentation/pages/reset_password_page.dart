import 'package:flutter/material.dart';
import 'package:participa_app/shared/widgets/custom_button.dart';
import 'package:participa_app/shared/widgets/custom_text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  final VoidCallback? onPasswordChanged;

  const ResetPasswordPage({super.key, this.onPasswordChanged});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void _trySubmit() {
    final pw = passwordController.text.trim();
    final conf = confirmController.text.trim();

    if (pw.isEmpty || conf.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Preencha todos os campos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (pw.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'A senha deve ter ao menos 8 carácteres',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (pw != conf) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'As senhas não coincidem',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Senha alterada com sucesso',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 3),
      ),
    );

    widget.onPasswordChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double maxHeight = constraints.maxHeight;

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/ParticipaSenha.png',
                      height: maxHeight * 0.20,
                      width: maxWidth * 0.9,
                      fit: BoxFit.cover,
                    ),

                    Text(
                      'Criar nova senha',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Nova senha',
                      obscureText: true,
                      icon: Icons.lock,
                    ),

                    const SizedBox(height: 10),

                    CustomTextField(
                      controller: confirmController,
                      hintText: 'Confirmar senha',
                      obscureText: true,
                      icon: Icons.lock_outline,
                    ),

                    const SizedBox(height: 12),

                    const SizedBox(height: 12),

                    CustomButton(
                      onTap: _trySubmit,
                      text: 'Alterar senha',
                      boxColor: Theme.of(context).colorScheme.onPrimary,
                      borderColor: Theme.of(context).colorScheme.onPrimary,
                      fontColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
