import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/models/cart/cart.dart';
import 'package:precious/models/cart_item/cart_item.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class CartRepository {
  Future<Cart> getCart() async {
    var response = await dio.request(EndPoint.cart,
        options: Options(method: 'GET', headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthRepository.idToken}'
        }));
    if (response.statusCode == 200) {
      if (response.data != null) {
        return Cart.fromJson(response.data);
      }
      return Cart(
        id: 1,
        user: FirebaseAuth.instance.currentUser!.uid,
        items: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } else {
      throw HttpException("${response.statusCode} ${response.statusMessage}");
    }
  }

  Future<Cart> updateQuantity(CartItem cartItem, double quantity) async {
    var response = await dio.request(EndPoint.cart,
        data: {
          'updates': [
            {'variant_id': cartItem.variant.id, 'quantity': quantity}
          ]
        },
        options: Options(method: 'PUT', headers: headers));
    if (response.statusCode == 200) {
      if (response.data != null) {
        return Cart.fromJson(response.data);
      }
      return Cart(
        id: 1,
        user: FirebaseAuth.instance.currentUser!.uid,
        items: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } else {
      throw HttpException("${response.statusCode} ${response.statusMessage}");
    }
  }

  Future<void> add(Variant variant) async {
    var response = await dio.request(EndPoint.cart,
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: jsonEncode({
          "updates": [
            {
              "variant_id": variant.id,
              "quantity": 1,
            }
          ]
        }));
    if (response.statusCode != 200) {
      throw DioException.badResponse(
          statusCode: response.statusCode!,
          requestOptions: response.requestOptions,
          response: response);
    }
  }
}
