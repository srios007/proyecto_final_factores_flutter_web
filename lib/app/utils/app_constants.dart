import 'package:intl/intl.dart';

///
/// Esta clase contiene todos los valores constantes en la aplicación
///

class AppConstants {
  final numberFormat = NumberFormat.currency(
    symbol: 'COP',
    decimalDigits: 0,
    locale: 'eu',
  );

  // WOMPI
  bool wompiIsSandbox = false;
  // FALSE: Se cobra dinero real de tarjetas de crédito reales.
  // TRUE: No se cobra dinero real. Se puede comprar sin tener tarjetas registradas.
  final String wompiCurrency = 'COP';
  int wompiCuotas = 12;
}

AppConstants constants = AppConstants();
