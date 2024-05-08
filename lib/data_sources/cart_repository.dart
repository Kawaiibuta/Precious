import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:precious/data_sources/cart/cart.dart';
import 'package:precious/data_sources/cart_item/cart_item.dart';
import 'package:precious/data_sources/login_repository.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class CartRepository {
  Future<Cart> getCart() async {
    // return Cart(
    //     id: 1,
    //     createdAt: DateTime.now(),
    //     updatedAt: DateTime.now(),
    //     items: [
    //       CartItem(
    //         id: 1,
    //         variant: Variant(
    //             img_paths_url: [
    //               'https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png'
    //             ],
    //             product: Product(
    //                 id: 182817,
    //                 name: 'UIT',
    //                 category_id: 123,
    //                 img_paths_url: [
    //                   'https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png'
    //                 ])),
    //         price: 220,
    //         quantity: 1,
    //       ),
    //       CartItem(
    //         id: 1,
    //         variant: Variant(
    //             img_paths_url: [
    //               'https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png'
    //             ],
    //             product: Product(
    //                 id: 182817,
    //                 name: 'UIT',
    //                 category_id: 123,
    //                 img_paths_url: [
    //                   'https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png'
    //                 ])),
    //         price: 220,
    //         quantity: 1,
    //       )
    //     ]);
    var response = await dio.request(EndPoint.cart,
        options: Options(method: 'GET', headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${LoginRepository.idToken}'
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
        options: Options(method: 'PUT', headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${LoginRepository.idToken}'
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
}
