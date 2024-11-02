import 'package:tv_showdown/data/models/show_model.dart';

abstract class ShowRemoteDataSource {
  Future<List<ShowModel>> getShowsByPage(int pageNumber);
}
