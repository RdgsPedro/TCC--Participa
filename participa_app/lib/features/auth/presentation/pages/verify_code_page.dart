import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:participa_app/shared/widgets/custom_button.dart';

class VerifyCodePage extends StatefulWidget {
  final VoidCallback? onVerified;

  const VerifyCodePage({super.key, this.onVerified});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  int seconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();

    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        setState(() {});
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => seconds = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        if (seconds > 0) {
          setState(() => seconds--);
        } else {
          _timer?.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  double _otpBoxSize(double maxWidth) {
    final candidate = maxWidth * 0.14;
    return candidate.clamp(48.0, 78.0);
  }

  Widget buildOtpBox(int index, double boxSize) {
    final hasValue = controllers[index].text.isNotEmpty;

    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: boxSize * 0.35,
          fontWeight: FontWeight.bold,
          color: hasValue
              ? Colors.white
              : Theme.of(context).colorScheme.onPrimary,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          counterText: "",
          fillColor: hasValue
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.tertiary,
          filled: true,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index + 1 < focusNodes.length) {
              focusNodes[index + 1].requestFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          } else {
            if (index - 1 >= 0) {
              focusNodes[index - 1].requestFocus();
            }
          }
        },
      ),
    );
  }

  String _collectCode() {
    return controllers.map((c) => c.text.trim()).join();
  }

  void _confirmCode() {
    final code = _collectCode();
    if (code.length < controllers.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Informe o código completo',
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
          'Código verificado com sucesso',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 3),
      ),
    );

    widget.onVerified?.call();
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Código reenviado',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 3),
      ),
    );
    for (var c in controllers) {
      c.clear();
    }
    focusNodes[0].requestFocus();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          final boxSize = _otpBoxSize(maxWidth > 500 ? 500 : maxWidth);

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ParticipaSenha.png',
                        height: maxHeight * 0.20,
                        width: maxWidth * 0.9,
                        fit: BoxFit.cover,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Enviamos um código para\n####@gmail.com",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          controllers.length,
                          (index) => buildOtpBox(index, boxSize),
                        ),
                      ),

                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: seconds == 0 ? _resendCode : null,
                        child: Text(
                          seconds > 0
                              ? "Reenviar código em $seconds s"
                              : "Não recebeu o código? Reenviar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: seconds > 0
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(context).colorScheme.inversePrimary,
                            decoration: seconds == 0
                                ? TextDecoration.underline
                                : null,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 25),

                      CustomButton(
                        onTap: _confirmCode,
                        text: "VERIFICAR",
                        boxColor: Theme.of(context).colorScheme.onPrimary,
                        borderColor: Theme.of(context).colorScheme.onPrimary,
                        fontColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
