import 'package:flutter/material.dart';
import 'package:participa_app/shared/widgets/custom_button.dart';
import 'package:participa_app/shared/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final sobrenomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  int _currentStep = 0;

  void _navigateStep(bool forward) {
    if (forward && _currentStep < 1) {
      setState(() {
        _currentStep++;
      });
    } else if (!forward && _currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else if (_currentStep == 1) {}
  }

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
                        "Cadastro",
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _currentStep == 0
                            ? "Informe seus dados pessoais"
                            : "Crie suas credenciais de acesso",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _currentStep == 0
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 20,
                              color: _currentStep == 0
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),

                          Container(
                            width: 50,
                            height: 3,
                            color: _currentStep >= 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                          ),

                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _currentStep == 1
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.lock,
                              size: 20,
                              color: _currentStep == 1
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      IndexedStack(
                        index: _currentStep,
                        children: [
                          Column(
                            children: [
                              CustomTextField(
                                controller: nameController,
                                hintText: "Nome",
                                obscureText: false,
                                icon: Icons.person,
                              ),

                              const SizedBox(height: 10),

                              CustomTextField(
                                controller: sobrenomeController,
                                hintText: "Sobrenome",
                                obscureText: false,
                                icon: Icons.person,
                              ),

                              const SizedBox(height: 10),

                              CustomTextField(
                                controller: cpfController,
                                hintText: "CPF",
                                obscureText: false,
                                icon: Icons.vpn_key,
                              ),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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

                              CustomTextField(
                                controller: confirmPasswordController,
                                hintText: "Confirmar Senha",
                                obscureText: true,
                                icon: Icons.password,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentStep == 1)
                            Expanded(
                              child: CustomButton(
                                onTap: () => _navigateStep(false),
                                text: "Voltar",
                                boxColor: Theme.of(
                                  context,
                                ).colorScheme.tertiary,
                                borderColor: Theme.of(
                                  context,
                                ).colorScheme.tertiary,
                                fontColor: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                              ),
                            ),

                          if (_currentStep == 1) const SizedBox(width: 10),

                          Expanded(
                            child: CustomButton(
                              onTap: () => _navigateStep(true),
                              text: _currentStep == 0 ? "Próximo" : "Cadastrar",
                              boxColor: Theme.of(context).colorScheme.onPrimary,
                              borderColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
                              fontColor: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Já possui conta?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.togglePages,
                            child: Text(
                              " Entrar",
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
