class ApiConstants {
  static const String baseUrl = "http://192.168.0.104:8080";

  // Auth endpoints
  static const String login = "$baseUrl/sign-in";
  static const String registerSeller = "$baseUrl/sign-up/seller";

  // Product endpoints
  static const String products = "$baseUrl/products";

  static const String getDishes = "$baseUrl/api/dish/restaurant";
}
