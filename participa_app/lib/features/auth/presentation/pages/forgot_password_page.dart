import 'package:flutter/material.dart';
import 'package:participa_app/shared/widgets/custom_button.dart';
import 'package:participa_app/shared/widgets/custom_text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  final VoidCallback? onSentCode;

  const ForgotPasswordPage({super.key, this.onSentCode});

  @override
  Widget build(BuildContext context) {
    final emailcpfController = TextEditingController();

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
                      'Recuperar senha',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    CustomTextField(
                      controller: emailcpfController,
                      hintText: 'Digite seu e-mail ou CPF',
                      obscureText: false,
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      onTap: () {
                        final emailcpf = emailcpfController.text.trim();
                        if (emailcpf.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Preencha o e-mail',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
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
                              'Código enviado para $emailcpf',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );

                        onSentCode?.call();
                      },
                      text: 'Enviar código',
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
