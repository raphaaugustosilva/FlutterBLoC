class TrailerModel {
  int _id;
  List<_Result> _resultados = [];

  TrailerModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _resultados = temp;
  }

  List<_Result> get results => _resultados;

  int get id => _id;
}

class _Result {
  String _id;
  String _iso_639_1;
  String _iso_3166_1;
  String _key;
  String _nome;
  String _site;
  int _tamanho;
  String _type;

  _Result(result) {
    _id = result['id'];
    _iso_639_1 = result['iso_639_1'];
    _iso_3166_1 = result['iso_3166_1'];
    _key = result['key'];
    _nome = result['name'];
    _site = result['site'];
    _tamanho = result['size'];
    _type = result['type'];
  }

  String get id => _id;

  String get iso_639_1 => _iso_639_1;

  String get iso_3166_1 => _iso_3166_1;

  String get key => _key;

  String get nome => _nome;

  String get site => _site;

  int get size => _tamanho;

  String get type => _type;
}