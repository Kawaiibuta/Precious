import 'package:dio/dio.dart';
import 'package:precious/data_sources/auth_repository.dart';

var dio = Dio();

Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': AuthRepository.idToken != null
          ? 'Bearer ${AuthRepository.idToken}'
          : ''
    };
