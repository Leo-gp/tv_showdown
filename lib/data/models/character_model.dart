import 'package:tv_showdown/domain/entities/character.dart';

class ShowCharacterModel extends Character {
  const ShowCharacterModel({
    required super.name,
    required super.image,
    required super.showName,
    required super.personName,
    required super.isSelf,
  });

  factory ShowCharacterModel.fromJson(Map<String, dynamic> json) {
    final PersonModel person = PersonModel.fromJson(json["person"]);
    final CharacterModel characterModel =
        CharacterModel.fromJson(json["character"]);
    return ShowCharacterModel(
      name: characterModel._name,
      image: characterModel._image?._medium,
      showName: "",
      personName: person._name,
      isSelf: json["self"],
    );
  }
}

class PersonModel {
  final String _name;

  PersonModel({required String name}) : _name = name;

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(name: json["name"]);
  }
}

class CharacterModel {
  final String _name;
  final CharacterImageModel? _image;

  CharacterModel({
    required String name,
    required CharacterImageModel? image,
  })  : _name = name,
        _image = image;

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final imageJson = json["image"];
    return CharacterModel(
      name: json["name"],
      image: imageJson != null
          ? CharacterImageModel.fromJson(json["image"])
          : null,
    );
  }
}

class CharacterImageModel {
  final String? _medium;

  CharacterImageModel({required String? medium}) : _medium = medium;

  factory CharacterImageModel.fromJson(Map<String, dynamic> json) {
    return CharacterImageModel(medium: json["medium"]);
  }
}
