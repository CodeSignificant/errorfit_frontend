import 'dart:io' show Platform;

import 'package:error_fit/config/environments/config.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// Web Razorpay SDK for Flutter Web
import 'package:flutter_razorpay_web/flutter_razorpay_web.dart' as razorpay_web;
// Native Razorpay SDK for Android/iOS
import 'package:razorpay_flutter/razorpay_flutter.dart' as razorpay_native;


class RazorpayManager {
  static final RazorpayManager _instance = RazorpayManager._internal();

  factory RazorpayManager() => _instance;

  RazorpayManager._internal();

  razorpay_native.Razorpay? _razorpayNative;
  razorpay_web.RazorpayWeb? _razorpayWeb;

  /// Initialize Razorpay and set event listeners
  void init({
    Function(Map<String, dynamic>response)? onSuccess,
    Function(Map<String, dynamic>response)? onError,
    Function(Map<String, dynamic> response)? onCancelled,
    Function()? onExternalWallet,
  }) {
    if (kIsWeb) {
      _razorpayWeb = razorpay_web.RazorpayWeb(
        onSuccess: (razorpay_web.RpaySuccessResponse response) {
          if (onSuccess != null) onSuccess({"paymentId": response.paymentId});
        },
        onCancel: (razorpay_web.RpayCancelResponse error) {
          onCancelled?.call({});
          print("Payment cancelled");
        },
        onFailed: (razorpay_web.RpayFailedResponse error) {
          // if (onError != null) onError({
          //   "code": error.code,
          //   "message": error.message,
          // });
        },
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      _razorpayNative = razorpay_native.Razorpay();

      _razorpayNative!.on(
        razorpay_native.Razorpay.EVENT_PAYMENT_SUCCESS,
            (razorpay_native.PaymentSuccessResponse response) {
          if (onSuccess != null) onSuccess({"paymentId": response.paymentId});
        },
      );

      _razorpayNative!.on(
        razorpay_native.Razorpay.EVENT_PAYMENT_ERROR,
            (razorpay_native.PaymentFailureResponse response) {
          if (onError != null) {
            onError({"code": response.code, "message": response.message});
          }
        },
      );

      _razorpayNative!.on(
        razorpay_native.Razorpay.EVENT_EXTERNAL_WALLET,
            (razorpay_native.ExternalWalletResponse response) {
          if (onExternalWallet != null) onExternalWallet();
        },
      );
    }
  }

  /// Create order via PaymentRepo and open Razorpay checkout
  Future<DataResponse> openCheckout(
 {
    required String? orderId,
    // required int amount, // in paise (e.g., 50000 = ₹500)
    // String contact = "",
    // String email = "",
  }
  ) async {
    // Create order on backend to get order_id
    // final result = await PaymentsRepo.cartOrder();
    // if (result is DataFailed) {
    //   return DataFailed("Unable to initiate the payment");
    // }
    // if (result.data == null || result.data == "") {
    //   return DataFailed("Unexpected response from order creation");
    // }
    //
    // final orderId = result.data;
    if (orderId == null || orderId.isEmpty) {
      return DataFailed("Invalid order ID from server");
    }

    final options = {
      'key': Config.razorpayKey, // Your Razorpay key
      // 'amount': amount*100,
      'order_id': orderId,       // Pass server created order id
      'name': Config.appName,
      'description': "Testing the payment gateway",
      'prefill': {'contact': Auth.phone, 'email': Auth.mail},
    };

    try {
      if (kIsWeb) {
        if (_razorpayWeb == null) {
          throw Exception("Razorpay Web not initialized. Call init() first.");
        }
        _razorpayWeb!.open(options);
      } else if (Platform.isAndroid || Platform.isIOS) {
        if (_razorpayNative == null) {
          throw Exception("Razorpay Native not initialized. Call init() first.");
        }
        _razorpayNative!.open(options);
      } else {
        throw UnsupportedError("Razorpay not supported on this platform");
      }
    } catch (e) {
      return DataFailed("Failed to open Razorpay checkout: $e");
    }

    // Return success indicating checkout opened properly
    return DataSuccess(null);
  }


  /// Clear Razorpay instances to avoid memory leaks
  void clear() {
    if (!kIsWeb) {
      _razorpayNative?.clear();
      _razorpayNative = null;
    }
    _razorpayWeb = null;
  }
}
