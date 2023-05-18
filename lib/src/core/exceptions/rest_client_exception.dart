class RestClientException implements Exception {
  final String message;

  RestClientException({this.message = 'Erro ao se comunicar com o servidor'});
}

class UnAuthorizeException implements Exception {}
