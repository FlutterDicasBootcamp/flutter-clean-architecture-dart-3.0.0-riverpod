sealed class ValidationCepMessagesConst {
  static String notEmpty(String inputLabel) => 'Favor inserir $inputLabel';

  static String length(String inputLabel, int length) =>
      '$inputLabel nāo deve exceder $length caractere${length > 1 ? 's' : ''} ';
}
