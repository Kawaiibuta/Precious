import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/user/user.dart';
import 'package:precious/presenters/user_presenter.dart';
import 'package:precious/resources/app_export.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);
  static const name = "order_form";
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  User? user;
  late Future<User> futureUser;
  UserPresenter userPresenter = UserPresenter();

  @override
  // void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Order",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: userPresenter
                  .getOneByUId(auth.FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Text("Ops, something wrong has happened"),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(top: 20.0.h),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all()),
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Danh sách sản phẩm",
                                    style: GoogleFonts.openSans(
                                        fontSize: 20.0.h,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                );
              })
        ],
      ),
    );
  }
}
