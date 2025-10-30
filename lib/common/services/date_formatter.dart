class DateFormatter {
  static const List<String> _weekdays = <String>[
    'segunda-feira',
    'terça-feira',
    'quarta-feira',
    'quinta-feira',
    'sexta-feira',
    'sábado',
    'domingo',
  ];

  static const List<String> _months = <String>[
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];

  static String formatFullDate(DateTime date) {
    final String weekday = _weekdays[date.weekday - 1];
    final String month = _months[date.month - 1];
    final String day = date.day.toString().padLeft(2, '0');

    return '${_capitalize(weekday)}, $day de ${_capitalize(month)}';
  }

  static String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() + value.substring(1);
  }
}
