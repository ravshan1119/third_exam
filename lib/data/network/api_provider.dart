import 'dart:convert';

import 'package:http/http.dart';
import 'package:third_exam_n8/data/model/category_model.dart';
import 'package:third_exam_n8/data/model/products_model.dart';

class ApiProvider {
  static Future<List<CategoryModel>> getCategory() async {
    Response response =
        await get(Uri.parse("https://imtixon.free.mockoapp.net/categories"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List?)
              ?.map((e) => CategoryModel.fromJson(e))
              .toList() ??
          [];
    }
    return [];
  }

  static Future<List<ProductsModel>>  getAllProducts() async {
    Response response =
        await get(Uri.parse("https://imtixon.free.mockoapp.net/products"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['data'] as List?)
              ?.map((e) => ProductsModel.fromJson(e))
              .toList() ??
          [];
    }
    return [];
  }

  static Future<List<ProductsModel>> getProductsById(int id) async {
    Response response =
    await get(Uri.parse("https://imtixon.free.mockoapp.net/categories/$id"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List?)
          ?.map((e) => ProductsModel.fromJson(e))
          .toList() ??
          [];
    }
    return [];
  }
}
