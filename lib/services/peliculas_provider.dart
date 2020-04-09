import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:peliculas_flutter/models/actores_model.dart';
import 'dart:convert';
import 'package:peliculas_flutter/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '5894760f02fb3fcac5eca92783bb340a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  //Crear el Stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    _popularesPage++;

    print('Cargando siguientes...');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  // PARA ACTORES
  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'  : _apiKey,
      'language' : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body); //transforma en un mapa
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }
}