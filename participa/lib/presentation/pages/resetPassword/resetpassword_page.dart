import 'package:flutter/material.dart';
import 'package:participa/presentation/widgets/custom_button/custom_button.dart';
import 'package:participa/presentation/widgets/textField/textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final confirmpasswordController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.beenhere,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Parabéns!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Sua conta está pronta para uso.\nVocê será redirecionado em alguns segundos.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Criar Nova Senha",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;
            bool isSmall = maxWidth < 400;
            bool isTablet = maxWidth >= 600;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isTablet ? 32 : 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ParticipaSenha.png',
                        height: isTablet
                            ? constraints.maxHeight * 0.3
                            : constraints.maxHeight * 0.25,
                        width: isTablet ? maxWidth * 0.7 : maxWidth * 0.9,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(height: isTablet ? 40 : 30),

                      Text(
                        "Criar sua nova senha",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: isSmall ? 20 : (isTablet ? 24 : 22),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: isTablet ? 40 : 30),

                      Textfield(
                        controller: passwordController,
                        hintText: "Senha",
                        obscureText: true,
                        icon: Icons.password,
                        inputType: TextInputType.text,
                      ),
                      const SizedBox(height: 15),
                      Textfield(
                        controller: confirmpasswordController,
                        hintText: "Confirmar senha",
                        obscureText: true,
                        icon: Icons.password,
                        inputType: TextInputType.text,
                      ),

                      const SizedBox(height: 30),

                      CustomButton(
                        text: "Continuar",
                        onPressed: _showSuccessPopup,
                      ),

                      SizedBox(height: isTablet ? 30 : 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
