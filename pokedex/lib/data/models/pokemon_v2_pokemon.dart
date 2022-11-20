import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'pokemon_v2_pokemonstat.dart';

class PokemonV2Pokemon extends Equatable {
  final int? id;
  final String? name;
  final List<PokemonV2Pokemonstat>? pokemonV2Pokemonstats;
  final String? pokemonV2Pokemonsprites;
  final num? height;
  final num? weight;

  const PokemonV2Pokemon({
    this.id,
    this.name,
    this.pokemonV2Pokemonstats,
    this.pokemonV2Pokemonsprites,
    this.height,
    this.weight,
  });

  factory PokemonV2Pokemon.fromMap(Map<String, dynamic> data) {
    return PokemonV2Pokemon(
      id: data['id'] as int?,
      name: data['name'] as String?,
      pokemonV2Pokemonstats: (data['pokemon_v2_pokemonstats'] as List<dynamic>?)
          ?.map((e) => PokemonV2Pokemonstat.fromMap(e as Map<String, dynamic>))
          .toList(),
      pokemonV2Pokemonsprites: _parseSpriteImage(data),
      height: data['height'] as int?,
      weight: data['weight'] as int?,
    );
  }

  static _parseSpriteImage(Map<String, dynamic> data) {
    final spriteString =
        ((data['pokemon_v2_pokemonsprites'] as List).first as Map)['sprites'];

    final sprites = jsonDecode(spriteString);

    return sprites["other"]["dream_world"]["front_default"];
  }

  PokemonV2Pokemon copyWith({
    int? id,
    String? name,
    List<PokemonV2Pokemonstat>? pokemonV2Pokemonstats,
    String? pokemonV2Pokemonsprites,
    num? height,
    num? weight,
  }) {
    return PokemonV2Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      pokemonV2Pokemonstats:
          pokemonV2Pokemonstats ?? this.pokemonV2Pokemonstats,
      pokemonV2Pokemonsprites:
          pokemonV2Pokemonsprites ?? this.pokemonV2Pokemonsprites,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      pokemonV2Pokemonstats,
      pokemonV2Pokemonsprites,
      height,
      weight,
    ];
  }
}
