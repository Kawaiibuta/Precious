class EndPoint {
  static const baseUrl = "https://api-precious-com.onrender.com/";
  static const product = "${baseUrl}api/product";
  static const category = "${baseUrl}api/category";
  static String productDetail(int id) => product + id.toString();
  static String categoryDetail(int id) => category + id.toString();
}
