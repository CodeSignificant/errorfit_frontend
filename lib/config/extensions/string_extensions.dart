import 'package:error_fit/config/environments/config.dart';
import 'package:intl/intl.dart';

import '../../core/resources/actions.dart';

extension StringExtensions on String {
  String get toRupee {
    try {
      double value = double.parse(this);
      final format = NumberFormat.simpleCurrency(locale: 'en_IN', decimalDigits: 1);
      return format.format(value);
    } catch (e) {
      return 'NA';
    }
  }

  String get autoUrl {
    if (startsWith("http")) return this;
    return "${Config.imageBaseUrl}$this";
  }

  String get formatStateShortCut {
    switch(this){
      case "Andhra Pradesh": return "AP";
      case "Telangana": return "TG";
      default: return"NA";
    }
  }

  String get accountFormat {
    final digitsOnly = replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i != 0 && (digitsOnly.length - i) % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }

    return buffer.toString();
  }

  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toTitleCase() {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((word) => word.capitalizeFirst()).join(' ');
  }

  String get formatPrice {
    if (isEmpty) return "NA";

    double? value = double.tryParse(this);
    if (value == null) return "NA";

    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  String percentageOf(String total) {
    double valueNum = double.tryParse(this) ?? 0.0;
    double totalNum = double.tryParse(total) ?? 0.0;

    if (totalNum == 0) return "NA";

    int percentage = ((valueNum / totalNum) * 100).round();
    if (percentage > 100) return "0%";
    return "${100 - percentage}%";
  }

  String formatIndianCurrencyDecimals({String symbol = '₹'}) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: symbol,
      decimalDigits: 2,
    );
    try{
      return formatter.format(double.parse(this));
    }catch(e){
      trace(e.toString());
      return this;
    }
  }

  String get formatReadableDate {
    try {
      final parsedDate = DateTime.parse(this).toLocal();
      final now = DateTime.now();

      final diff = now.difference(parsedDate);

      if (diff.inMinutes < 1) return "Now";

      if (parsedDate.year == now.year &&
          parsedDate.month == now.month &&
          parsedDate.day == now.day) {
        if (diff.inHours < 10) return "${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago";
        return "Today";
      }

      return DateFormat("dd MMM yyyy").format(parsedDate);
    } catch (e) {
      return this; // fallback to original string if parsing fails
    }
  }
}
