import 'package:flutter/material.dart';

class CreateOrderPage extends StatefulWidget {
  static const name = '/createOrder';

  const CreateOrderPage.CompletePaymentPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Hello World'));
  }
}
