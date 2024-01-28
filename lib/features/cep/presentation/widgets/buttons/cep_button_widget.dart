import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/theme_extension.dart';

class CepButtonWidget extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final FocusNode? focusNode;

  const CepButtonWidget({
    super.key,
    this.focusNode,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      focusNode: focusNode,
      key: key,
      onPressed: onPressed,
      child: Text(
        'Procurar',
        style: context.getTextTheme.bodyMedium,
      ),
    );
  }
}
