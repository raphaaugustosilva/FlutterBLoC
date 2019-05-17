class ItemModel {
  int _pagina;
  int _totalResultados;
  int _totalPaginas;
  List<_Result> _resultados = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _pagina = parsedJson['page'];
    _totalResultados = parsedJson['total_results'];
    _totalPaginas = parsedJson['total_pages'];
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _resultados = temp;
  }

  List<_Result> get resultados => _resultados;

  int get totalPaginas => _totalPaginas;

  int get totalResultados => _totalResultados;

  int get pagina => _pagina;
}

class _Result {
  int _votosContagem;
  int _id;
  bool _video;
  var _votosMedia;
  String _titulo;
  double _popularidade;
  String _posterPath;
  String _idiomaOriginal;
  String _tituloOriginal;
  List<int> _generosIds = [];
  String _backdropPath;
  bool _adulto;
  String _overview;
  String _dataLancamento;

  _Result(result) {
    _votosContagem = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _votosMedia = result['vote_average'];
    _titulo = result['title'];
    _popularidade = result['popularity'];
    _posterPath = result['poster_path'];
    _idiomaOriginal = result['original_language'];
    _tituloOriginal = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _generosIds.add(result['genre_ids'][i]);
    }
    _backdropPath = result['backdrop_path'];
    _adulto = result['adult'];
    _overview = result['overview'];
    _dataLancamento = result['release_date'];
  }

  String get dataLancamento => _dataLancamento;

  String get overview => _overview;

  bool get adulto => _adulto;

  String get backdropPath => _backdropPath;

  List<int> get generosIds => _generosIds;

  String get tituloOriginal => _tituloOriginal;

  String get idiomaOriginal => _idiomaOriginal;

  String get posterPath => _posterPath;

  double get popularidade => _popularidade;

  String get titulo => _titulo;

  dynamic get votosMedia => _votosMedia;

  bool get video => _video;

  int get id => _id;

  int get votosContagem => _votosContagem;
}