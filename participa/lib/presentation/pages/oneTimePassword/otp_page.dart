import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:participa/presentation/widgets/custom_button/custom_button.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  int seconds = 60;
  late final ticker;

  @override
  void initState() {
    super.initState();
    ticker = Stream.periodic(const Duration(seconds: 1), (x) => x).listen((x) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        ticker.cancel();
      }
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    ticker.cancel();
    super.dispose();
  }

  Widget buildOtpBox(int index, double boxSize) {
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: TextField(
        controller: controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: boxSize * 0.35,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty && index < controllers.length - 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
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

            double boxSize = isTablet ? 90 : (isSmall ? 60 : 75);

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isTablet ? 32 : 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Enviamos um código para \n ####@gmail.com",
                        style: TextStyle(
                          fontSize: isSmall ? 14 : (isTablet ? 18 : 16),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: isTablet ? 40 : 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          controllers.length,
                          (index) => buildOtpBox(index, boxSize),
                        ),
                      ),

                      SizedBox(height: isTablet ? 30 : 20),

                      Text(
                        seconds > 0
                            ? "Reenviar código em $seconds s"
                            : "Não recebeu o código? Reenviar",
                        style: TextStyle(
                          fontSize: isSmall ? 14 : (isTablet ? 16 : 15),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: isTablet ? 40 : 30),

                      CustomButton(
                        text: "Continuar",
                        onPressed: () {
                          Navigator.pushNamed(context, "/reset");
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
