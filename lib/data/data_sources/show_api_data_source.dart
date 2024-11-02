import 'dart:convert';

import 'package:tv_showdown/core/error/exception.dart';
import 'package:tv_showdown/data/data_sources/api_constants.dart';
import 'package:tv_showdown/data/data_sources/show_remote_data_source.dart';
import 'package:tv_showdown/data/models/show_model.dart';
import 'package:http/http.dart' as http;

class ShowApiDataSource implements ShowRemoteDataSource {
  @override
  Future<List<ShowModel>> getShowsByPage(int pageNumber) async {
    final Uri uri = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.showsPath,
      {ApiConstants.pageQueryParam: "$pageNumber"},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> showsJson = jsonDecode(response.body);
      return showsJson.map((showJson) => ShowModel.fromJson(showJson)).toList();
    } else {
      throw ServerException();
    }
  }
}
