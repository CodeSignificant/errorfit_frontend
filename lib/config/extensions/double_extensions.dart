import 'package:intl/intl.dart';

extension DoubleExtensions on double {

  String get formatShortcutCountDecimals {
    if (this >= 10000000) {
      return '${(this / 10000000).toStringAsFixed(1)}Cr';
    } else if (this >= 100000) {
      return '${(this / 100000).toStringAsFixed(1)}L';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    } else {
      return toStringAsFixed(1);
    }
  }

  /// Without decimals (e.g., 1K, 2L, 3Cr)
  String get formatShortcutCount {
    if (this >= 10000000) {
      return '${(this / 10000000).floor()}Cr';
    } else if (this >= 100000) {
      return '${(this / 100000).floor()}L';
    } else if (this >= 1000) {
      return '${(this / 1000).floor()}K';
    } else {
      return floor().toString();
    }
  }

  String formatIndianCurrencyDecimals({String symbol = '₹'}) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(this);
  }

  String get formatPrice {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }



}
