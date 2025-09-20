import 'package:flutter/material.dart';
import 'package:participa_app/shared/widgets/custom_button.dart';

import 'package:participa_app/shared/widgets/custom_text_field.dart';
import 'package:participa_app/shared/widgets/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  final void Function()? goToForgotPassword;

  const LoginPage({super.key, this.togglePages, this.goToForgotPassword});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;
            double maxHeight = constraints.maxHeight;

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Participa.png',
                        height: maxHeight * 0.20,
                        width: maxWidth * 0.9,
                        fit: BoxFit.cover,
                      ),

                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Faça o login para continuar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 25),

                      CustomTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false,
                        icon: Icons.email,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: passwordController,
                        hintText: "Senha",
                        obscureText: true,
                        icon: Icons.password,
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: widget.goToForgotPassword,
                            child: Text(
                              "Esqueceu sua Senha?",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      CustomButton(
                        onTap: () {},
                        text: "ENTRAR",
                        boxColor: Theme.of(context).colorScheme.onPrimary,
                        borderColor: Theme.of(context).colorScheme.onPrimary,
                        fontColor: Colors.white,
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              "Ou faça login com",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SignInButton(
                            onTap: () {},
                            imageIcon: 'assets/images/googleIcon.png',
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Não possue conta?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.togglePages,
                            child: Text(
                              " Cadastrar-se",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
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
