class Show {
  final int _id;
  final String _name;
  final int _weight;

  int get id => _id;
  String get name => _name;
  int get weight => _weight;

  const Show({
    required int id,
    required String name,
    required int weight,
  })  : _id = id,
        _name = name,
        _weight = weight;
}
