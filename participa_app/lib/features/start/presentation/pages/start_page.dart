import 'package:flutter/material.dart';
import 'package:participa_app/features/auth/presentation/pages/auth_page.dart';
import 'package:participa_app/shared/widgets/custom_button.dart';
import 'package:participa_app/shared/widgets/service_card.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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
                        height: maxHeight * 0.2,
                        width: maxWidth * 0.9,
                        fit: BoxFit.cover,
                      ),

                      Text(
                        "PARTICIPA",
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Nossa voz, ativa e unida",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Conheça e acesse os serviçõs do Participa",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 25),

                      CustomButton(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const AuthPage(initialView: AuthView.login),
                            ), // abre Login
                          );
                        },
                        text: "ENTRAR",
                        boxColor: Theme.of(context).colorScheme.onPrimary,
                        borderColor: Theme.of(context).colorScheme.onPrimary,
                        fontColor: Colors.white,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Entre com sua conta Participa ou faça o cadastro!",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 12),

                      CustomButton(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AuthPage(
                                initialView: AuthView.register,
                              ),
                            ),
                          );
                        },
                        text: "Cadastrar",
                        boxColor: Theme.of(context).colorScheme.tertiary,
                        borderColor: Theme.of(context).colorScheme.tertiary,
                        fontColor: Theme.of(context).colorScheme.inversePrimary,
                      ),

                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Serviços sem Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.2,
                        children: const [
                          ServiceCard(
                            icon: Icons.sensors,
                            label: 'Transmissões',
                            pageRedirection: "",
                          ),
                          ServiceCard(
                            icon: Icons.newspaper,
                            label: 'Notícias',
                            pageRedirection: "",
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
