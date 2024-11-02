class Character {
  final String _name;
  final String? _image;
  final String _showName;
  final String _personName;
  final bool _isSelf;

  String get name => _name;
  String? get image => _image;
  String get showName => _showName;
  String get personName => _personName;
  bool get isSelf => _isSelf;

  const Character({
    required String name,
    required String? image,
    required String showName,
    required String personName,
    required bool isSelf,
  })  : _name = name,
        _image = image,
        _showName = showName,
        _personName = personName,
        _isSelf = isSelf;

  Character copyWith({
    String? name,
    String? image,
    String? showName,
    String? personName,
    bool? isSelf,
  }) {
    return Character(
      name: name ?? _name,
      image: image ?? _image,
      showName: showName ?? _showName,
      personName: personName ?? _personName,
      isSelf: isSelf ?? _isSelf,
    );
  }
}
