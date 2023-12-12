import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../common/utils/base_exception.dart';
import '../../../home/data/model/product_response_model.dart';

abstract class PLPDataSource {
  Future<ProductResponseModel> getPLPResponseData();
}

class PLPDataSourceImpl extends PLPDataSource {
  http.Client? client;
  PLPDataSourceImpl([http.Client? client]) {
    this.client = client ?? http.Client();
  }

  @override
  Future<ProductResponseModel> getPLPResponseData() async {
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
