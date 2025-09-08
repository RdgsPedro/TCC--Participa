import 'package:flutter/material.dart';
import 'package:participa/presentation/widgets/custom_button/custom_button.dart';
import 'package:participa/presentation/widgets/service_card/service_card.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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

            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/images/PARTICIPA.png',
                        height: constraints.maxHeight * 0.3,
                        width: maxWidth * 0.95,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "PARTICIPA",
                        style: TextStyle(
                          fontSize: isSmall ? 28 : 35,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),

                      Text(
                        "Nossa voz, ativa e unida",
                        style: TextStyle(
                          fontSize: isSmall ? 16 : 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 5),
                      Text(
                        "Conheça e acesse os serviços do Participa",
                        style: TextStyle(
                          fontSize: isSmall ? 12 : 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      CustomButton(
                        text: "ENTRAR",
                        onPressed: () =>
                            Navigator.of(context).popAndPushNamed('/login'),
                      ),

                      const SizedBox(height: 15),
                      Text(
                        "Entre com sua conta Participa ou faça o cadastro!",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 15),
                      const ButtonRegister(),
                      const SizedBox(height: 15),

                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Serviços sem Login",
                          style: TextStyle(
                            fontSize: isSmall ? 16 : 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: isTablet ? 4 : 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: isSmall ? 2 : 2.5,
                        children: const [
                          CardsButtons(
                            icon: Icons.sensors,
                            label: 'Transmissões',
                            pageRedirection: "/transmission",
                          ),
                          CardsButtons(
                            icon: Icons.newspaper,
                            label: 'Notícias',
                            pageRedirection: "/news",
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

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
            fixedSize: Size(constraints.maxWidth * 0.9, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () => Navigator.of(context).popAndPushNamed('/register'),
          child: Text(
            "CADASTRAR",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
