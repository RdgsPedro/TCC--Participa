import 'package:flutter/material.dart';
import 'package:participa_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:participa_app/features/auth/presentation/pages/login_page.dart';
import 'package:participa_app/features/auth/presentation/pages/register_page.dart';
import 'package:participa_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:participa_app/features/auth/presentation/pages/verify_code_page.dart';

enum AuthView { login, register, forgotPassword, verifyCode, resetPassword }

class AuthPage extends StatefulWidget {
  final AuthView initialView;

  const AuthPage({super.key, this.initialView = AuthView.login});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthView currentView;
  final List<AuthView> _history = [];

  @override
  void initState() {
    super.initState();
    currentView = widget.initialView;
  }

  void _pushView(AuthView next) {
    setState(() {
      _history.add(currentView);
      currentView = next;
    });
  }

  void showLogin() {
    setState(() {
      _history.clear();
      currentView = AuthView.login;
    });
  }

  void showRegister() => _pushView(AuthView.register);
  void showForgotPassword() => _pushView(AuthView.forgotPassword);
  void showVerifyCode() => _pushView(AuthView.verifyCode);
  void showResetPassword() => _pushView(AuthView.resetPassword);

  void _handleBack() {
    setState(() {
      if (_history.isNotEmpty) {
        currentView = _history.removeLast();
      } else {
        currentView = AuthView.login;
      }
    });
  }

  bool _viewNeedsAppBar(AuthView v) {
    switch (v) {
      case AuthView.login:
      case AuthView.register:
        return false;
      default:
        return true;
    }
  }

  String _titleForView(AuthView v) {
    switch (v) {
      case AuthView.forgotPassword:
        return 'Recuperar Senha';
      case AuthView.verifyCode:
        return 'Código de Verificação';
      case AuthView.resetPassword:
        return 'Alterar Senha';
      case AuthView.register:
        return 'Cadastro';
      case AuthView.login:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (currentView) {
      case AuthView.login:
        content = LoginPage(
          togglePages: showRegister,
          goToForgotPassword: showForgotPassword,
        );
        break;

      case AuthView.register:
        content = RegisterPage(togglePages: showLogin);
        break;

      case AuthView.forgotPassword:
        content = ForgotPasswordPage(onSentCode: showVerifyCode);
        break;

      case AuthView.verifyCode:
        content = VerifyCodePage(onVerified: showResetPassword);
        break;

      case AuthView.resetPassword:
        content = ResetPasswordPage(onPasswordChanged: showLogin);
        break;
    }

    if (_viewNeedsAppBar(currentView)) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            _titleForView(currentView),
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: BackButton(onPressed: _handleBack),
        ),
        body: content,
      );
    } else {
      return content;
    }
  }
}
