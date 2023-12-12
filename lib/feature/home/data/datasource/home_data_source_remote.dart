import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../common/utils/base_exception.dart';
import '../model/product_response_model.dart';

abstract class HomeDataSource {
  Future<ProductResponseModel> getHomeResponseData();
}

class HomeDataSourceImpl extends HomeDataSource {
  http.Client? client;
  HomeDataSourceImpl([http.Client? client]) {
    this.client = client ?? http.Client();
  }

  @override
  Future<ProductResponseModel> getHomeResponseData() async {
    final response = await client!.get(
      Uri.parse('https://dummyjson.com/products'),
    );

    if (response.statusCode == 200) {
      final product = json.decode(response.body);
      return ProductResponseModel.fromJson(product);
    } else {
      throw BaseException(
          message: response.body.toString(), code: response.statusCode);
    }
  }
}
