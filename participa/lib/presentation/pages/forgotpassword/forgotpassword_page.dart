import 'package:flutter/material.dart';
import 'package:participa/presentation/widgets/custom_button/custom_button.dart';
import 'package:participa/presentation/widgets/textField/textfield.dart';

class ForgotpasswordPage extends StatefulWidget {
  const ForgotpasswordPage({super.key});

  @override
  State<ForgotpasswordPage> createState() => _ForgotpasswordPageState();
}

class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  final cpfEmailController = TextEditingController();

  @override
  void dispose() {
    cpfEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Esqueci a senha",
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
                        "Recuperar senha",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: isSmall ? 20 : (isTablet ? 28 : 24),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isTablet ? 15 : 10),

                      Text(
                        "Digite seu CPF ou e-mail para redefinir sua senha",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: isSmall ? 14 : (isTablet ? 16 : 15),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isTablet ? 40 : 30),

                      Textfield(
                        controller: cpfEmailController,
                        hintText: "CPF ou E-mail",
                        obscureText: false,
                        icon: Icons.person_outline,
                        inputType: TextInputType.text,
                      ),

                      const SizedBox(height: 30),

                      CustomButton(
                        text: "Continuar",
                        onPressed: () {
                          Navigator.pushNamed(context, "/otp");
                        },
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
