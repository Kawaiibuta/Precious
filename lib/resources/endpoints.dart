class EndPoint {
  static const baseUrl = "https://api-precious-com.onrender.com/";
  static const login = "${baseUrl}api/auth/login_firebase";
  static const product = "${baseUrl}api/product/";

  static const cart = "${baseUrl}api/cart";
  static String productWithParam(
          {int start = 1, int quantity = -1, int type = -1}) =>
      "${baseUrl}api/product?start=$start&quantity=$quantity${type != -1 ? "&type=$type" : ""}";
  static const category = "${baseUrl}api/category";
  static String productDetail(int id) => product + id.toString();
  static String categoryDetail(int id) => category + id.toString();
  static const type = "${baseUrl}api/type";
}
