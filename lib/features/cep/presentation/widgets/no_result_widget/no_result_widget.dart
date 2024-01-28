import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/theme_extension.dart';

class NoResultWidget extends StatelessWidget {
  final String text;
  const NoResultWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.getTextTheme.bodyMedium,
    );
  }
}
