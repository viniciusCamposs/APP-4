import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pokedex_tarde/core/app_errors.dart';
import 'package:pokedex_tarde/models/pokemon_model.dart';
import 'package:pokedex_tarde/models/pokemon_result_model.dart';
import 'package:pokedex_tarde/repositories/poke_repository.dart';

class PokeRepositoryImpl implements PokeRepository {
  @override
  Future<Either<Failure, List<PokemonModel>>> fetch(
      {int offset = 0, int limit = 20}) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=$limit',
      );
      final data = response.data['results'] as List;
      final list =
          data.map((pokemon) => PokemonResultModel.fromMap(pokemon)).toList();

      final pokemons = <PokemonModel>[];
      for (var item in list) {
        final pokemon = await fetchByUrl(item.url);
        pokemons.add(pokemon);
      }
      return Right(pokemons);
    } on DioError catch (error) {
      return Left(ApiError(error.message));
    } catch (error) {
      return Left(UnknowError(error.toString()));
    }
  }

  @override
  Future<PokemonModel> fetchByUrl(String url) async {
    final dio = Dio();
    final response = await dio.get(url);
    return PokemonModel.fromMap(response.data);
  }
}
