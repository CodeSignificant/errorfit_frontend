import '../../../config/environments/config.dart';
class ApiSheet {
  static final auth = AuthApi();
  static final products = ProductsApi();
  static final address = AddressApi();
  static final users = UsersApi();
  static final orders = OrdersApi();
  static final services = ServicesApi();
  static final notifications = NotificationsApi();
  static final wishlist = WishlistApi();
  static final cart = CartApi();
  static final public = PublicApi();
  static final views = ViewsApi();
  static final payments = PaymentsApi();
}

class AuthApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Auth";

  // POST(id_token, device)
  String get verifyGoogleLogin => "$_baseUrl/Google/verify_google_login_id.php";

  // POST(mail)
  String get mailOTP => "$_baseUrl/MailOTP/Login.php";

  // // POST(otp, device) => token
  // String get verifyMailOTP => "$_baseUrl/MailOTP/VerifyMailOTP.php";

  // POST(otp, device) => token
  String get verifyOTP => "$_baseUrl/VerifyOTP.php";

  // POST(phone, country_code)
  String get phoneOTP => "$_baseUrl/PhoneOTP/Login.php";

  // POST(otp, device) => token
  String get verifyPhoneOTP => "$_baseUrl/PhoneOTP/VerifyPhoneOTP.php";

  // POST(mail, password, device)
  String get login => "$_baseUrl/LoginPassword/Login.php";

  // // POST(mail)
  // String get forgot => "$_baseUrl/LoginPassword/Forgot.php";
  //
  // // POST(otp, new_password) => token
  // String get verifyForgot => "$_baseUrl/LoginPassword/VerifyForgot.php";

  // GET() => Secure
  String get info => "$_baseUrl/Info.php";

  // GET()=>Secure
  String get refreshToken => "$_baseUrl/RefreshToken.php";

  // GET()=>Secure
  String get logout => "$_baseUrl/Logout.php";

  // GET()=>Secure
  String get logoutAll => "$_baseUrl/LogoutAll.php";
}

class ProductsApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Products"; ////errorfit.4ss.in/api/v1/Services/Products/Public/FilterProducts.php

  // POST(page_no)
  String get filter => "$_baseUrl/Public/FilterProducts.php";

  // POST(search)
  String get search => "$_baseUrl/Public/SearchProducts.php";

  // POST(id)
  String get details => "$_baseUrl/Public/ProductDetails.php";

  // GET()
  String get filterJson => "$_baseUrl/Public/get_filter_json.php";

  // POST(search, filter)
  String get searchFilter => "$_baseUrl/Public/search_products.php";

}


class ServicesApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Support"; ////errorfit.4ss.in/api/v1/Services/Products/Public/FilterProducts.php

  // POST(message) => Secure
  String get raise => "$_baseUrl/Create.php";

}

class AddressApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Users/Address";

  // POST(name, mail, phone, country_code, pincode, address, lat?, lon?, make_default) => Secure
  String get addNew => "$_baseUrl/Create.php";

  // POST(id, name, mail, phone, country_code, pincode, address, lat?, lon?, make_default) => Secure
  String get update => "$_baseUrl/Update.php";

  // POST(id) => Secure
  String get delete => "$_baseUrl/Delete.php";

  // GET => Secure
  String get fetch => "$_baseUrl/Fetch.php";

  // GET => Secure
  String get fetchDefault => "$_baseUrl/FetchDefault.php";

  // POST(id) => Secure
  String get updateDefault => "$_baseUrl/UpdateDefault.php";
}

class OrdersApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Orders";


  // GET(?page) => Secure
  String fetch(int page) => "$_baseUrl/all_orders.php?page=$page";

  // GET(address_id, payment_mode, coupon) => Secure
  String get createOrder => "$_baseUrl/CreateOrder.php";

  // GET(address_id, coupon) => Secure
  String get calculateOrders => "$_baseUrl/OrderCalculation.php";
}

class UsersApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Users/Details";

  // POST(name, mail, phone, country_code, pincode, address, lat?, lon?) => Secure
  String get addNew => "$_baseUrl/Create.php";

  // POST(id, name, mail, phone, country_code, pincode, address, lat?, lon?) => Secure
  String get update => "$_baseUrl/Update.php";

  // POST(id) => Secure
  String get delete => "$_baseUrl/Delete.php";

  // GET => Secure
  String get fetch => "$_baseUrl/Fetch.php";
}

class WishlistApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Users/Liked";

  // POST(product_id, status) => Secure
  String get addNew => "$_baseUrl/Set.php";

  // GET() => Secure
  String fetch(int page) => "$_baseUrl/all_wishlist.php?page=$page";

}

class CartApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Users/Cart";

  // POST(product_id, count, selected) => Secure
  String get addNew => "$_baseUrl/Set.php";

  // POST(id) => Secure
  String get remove => "$_baseUrl/Remove.php";

  // GET() => Secure
  String get fetch => "$_baseUrl/Fetch.php";

}

class PublicApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Public";

  // GET()
  String get homeFlow => "$_baseUrl/Home/Flow.php";

}

class NotificationsApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Users/Notifications";

  // // POST(name, mail, phone, country_code, pincode, address, lat?, lon?) => Secure
  // String get addNew => "$_baseUrl/Create.php";

  // POST(id, name, mail, phone, country_code, pincode, address, lat?, lon?) => Secure
  // String get update => "$_baseUrl/Update.php";

  // // POST(id) => Secure
  // String get delete => "$_baseUrl/Delete.php";

  // GET => Secure
  String get fetch => "$_baseUrl/Fetch.php";
}

class ViewsApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Users/Views";

  // GET => Secure
  String get recentlyViewed => "$_baseUrl/Fetch.php";
}

class PaymentsApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/Payments";

  // POST() => Secure
  String get cartOrder => "$_baseUrl/Razorpay/CartOrder.php";
}
