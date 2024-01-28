import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/theme_extension.dart';

class CepTextFieldWidget extends StatelessWidget {
  final TextEditingController? textEC;
  final String? Function(String?)? validator;
  final String? placeholder;

  const CepTextFieldWidget({
    super.key,
    this.textEC,
    this.validator,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.getTextTheme.bodyMedium,
      key: key,
      controller: textEC,
      validator: validator,
      decoration: InputDecoration(hintText: placeholder),
    );
  }
}
