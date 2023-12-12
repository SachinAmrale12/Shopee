import 'dart:convert';
import 'package:shopee/feature/pdp/data/model/product_detail_response_model.dart';
import 'package:http/http.dart' as http;
import '../../../../common/utils/base_exception.dart';

abstract class PdpDataSource {
  Future<ProductDetailResponseModel> getProductResponseData(int productId);
}

class PdpDataSourceImpl extends PdpDataSource {
  http.Client? client;
  PdpDataSourceImpl([http.Client? client]) {
    this.client = client ?? http.Client();
  }

  @override
  Future<ProductDetailResponseModel> getProductResponseData(
      int productId) async {
    final response = await client!.get(
      Uri.parse('https://dummyjson.com/products/$productId'),
    );

    if (response.statusCode == 200) {
      final product = json.decode(response.body);
      return ProductDetailResponseModel.fromJson(product);
    } else {
      throw BaseException(
          message: response.body.toString(), code: response.statusCode);
    }
  }
}
