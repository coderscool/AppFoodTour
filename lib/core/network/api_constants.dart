class ApiConstants {
  static const String baseUrl = "http://10.0.2.2:8080";

  // Auth endpoints
  static const String login = "$baseUrl/sign-in";
  static const String registerSeller = "$baseUrl/sign-up/seller";

  // Product endpoints
  static const String products = "$baseUrl/products";
}
