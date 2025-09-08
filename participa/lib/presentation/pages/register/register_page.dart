import 'package:flutter/material.dart';
import 'package:participa/presentation/widgets/custom_button/custom_button.dart';

import 'package:participa/presentation/widgets/textField/textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cpfController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                        'assets/images/PARTICIPA.png',
                        height: isTablet
                            ? constraints.maxHeight * 0.3
                            : constraints.maxHeight * 0.2,
                        width: isTablet ? maxWidth * 0.7 : maxWidth * 0.8,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(height: isTablet ? 30 : 20),

                      Text(
                        "Cadastro",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: isSmall ? 28 : (isTablet ? 38 : 34),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Faça seu cadastro para continuar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: isSmall ? 14 : (isTablet ? 18 : 16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isTablet ? 40 : 30),

                      Textfield(
                        controller: nameController,
                        hintText: "Nome",
                        obscureText: false,
                        icon: Icons.person,
                        inputType: TextInputType.name,
                      ),
                      const SizedBox(height: 15),

                      Textfield(
                        controller: cpfController,
                        hintText: "CPF",
                        obscureText: false,
                        icon: Icons.vpn_key_sharp,
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),

                      Textfield(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false,
                        icon: Icons.alternate_email,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),

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

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() => isChecked = value ?? false);
                            },
                          ),
                          Text(
                            "Aceito os termos",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: isTablet ? 16 : 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      CustomButton(text: "Cadastrar", onPressed: () {}),

                      SizedBox(height: isTablet ? 30 : 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Já possui conta?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: isTablet ? 17 : 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).popAndPushNamed('/login'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              overlayColor: Colors.transparent,
                            ),
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: isTablet ? 17 : 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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
