import 'package:flutter/services.dart';

class Validators {
  // -----------------------
  // Email
  // -----------------------
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'E-mail é obrigatório';
    }
    final v = value.trim();
    final emailRegex = RegExp(
      r"^[A-Za-z0-9]+([._%+-]?[A-Za-z0-9]+)*@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$",
    );
    if (!emailRegex.hasMatch(v)) return 'Formato de e-mail inválido';
    return null;
  }

  // -----------------------
  // Senha
  // Regras: mínimo 8, pelo menos 1 letra maiúscula, 1 minúscula, 1 número e 1 caractere especial
  // (ajuste conforme quiser)
  // -----------------------
  static String? validatePassword(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return 'Senha é obrigatória';
    if (value.length < minLength) {
      return 'Senha deve ter ao menos $minLength caracteres';
    }
    final hasUpper = RegExp(r'[A-Z]').hasMatch(value);
    final hasLower = RegExp(r'[a-z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    final hasSpecial = RegExp(
      'r[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:\'\"\\|,.<>\/\?~`]',
    ).hasMatch(value);

    if (!hasUpper || !hasLower || !hasDigit || !hasSpecial) {
      return 'Senha deve conter maiúscula, minúscula, número e caractere especial';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != originalPassword) return 'Senhas não coincidem';
    return null;
  }

  // -----------------------
  // Nome / Sobrenome
  // -----------------------
  static String? validateName(String? value, {String fieldName = 'Nome'}) {
    if (value == null || value.trim().isEmpty)
      return '$fieldName é obrigatório';
    if (value.trim().length < 2) return '$fieldName muito curto';
    // evita números no nome (opcional)
    if (RegExp(r'\d').hasMatch(value))
      return '$fieldName contém números inválidos';
    return null;
  }

  // -----------------------
  // CPF
  // - aceita com ou sem máscara
  // - aplica algoritmo de verificação (dígitos verificadores)
  // -----------------------
  static String? validateCpf(String? value) {
    if (value == null || value.trim().isEmpty) return 'CPF é obrigatório';
    final digits = unmask(value);
    if (digits.length != 11) return 'CPF deve ter 11 dígitos';

    // rejeita sequências repetidas (11111111111, 22222222222, etc)
    if (RegExp(r'^(\d)\1{10}$').hasMatch(digits)) return 'CPF inválido';

    // cálculo dos dígitos verificadores
    final nums = digits.split('').map(int.parse).toList();

    int calcDigit(List<int> arr, int len) {
      int sum = 0;
      for (int i = 0; i < len; i++) sum += arr[i] * (len + 1 - i);
      int r = (sum * 10) % 11;
      if (r == 10) r = 0;
      return r;
    }

    final d1 = calcDigit(nums, 9);
    if (d1 != nums[9]) return 'CPF inválido';

    final d2 = calcDigit(nums, 10);
    if (d2 != nums[10]) return 'CPF inválido';

    return null;
  }

  // -----------------------
  // Utils
  // -----------------------
  /// Remove tudo que não for dígito
  static String unmask(String value) => value.replaceAll(RegExp(r'\D'), '');

  /// Retorna true/false se o CPF é válido (útil em lógicas)
  static bool isCpfValid(String value) => validateCpf(value) == null;

  // -----------------------
  // Generic required
  // -----------------------
  static String? validateRequired(String? value, {String field = 'Campo'}) {
    if (value == null || value.trim().isEmpty) return '$field é obrigatório';
    return null;
  }

  // -----------------------
  // Category / selection helpers
  // -----------------------
  static String? validateCategorySelection(List<String>? categories) {
    if (categories == null || categories.isEmpty)
      return 'Selecione pelo menos uma categoria';
    return null;
  }
}

// -----------------------
// CPF InputFormatter (mask): 000.000.000-00
// -----------------------
class CpfInputFormatter extends TextInputFormatter {
  /// recebe o novo valor e retorna a versão formatada (XXX.XXX.XXX-XX)
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digitsOnly.length > 11
        ? digitsOnly.substring(0, 11)
        : digitsOnly;

    final buffer = StringBuffer();
    for (int i = 0; i < limited.length; i++) {
      buffer.write(limited[i]);
      if (i == 2 || i == 5) buffer.write('.');
      if (i == 8) buffer.write('-');
    }

    final formatted = buffer.toString();
    // calcula nova posição do cursor:
    int selectionIndex = formatted.length;
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
