import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

var dio = Dio();

var headers = {
  'accept': 'application/json',
  'Authorization': FirebaseAuth.instance.currentUser?.uid ?? ""
};
