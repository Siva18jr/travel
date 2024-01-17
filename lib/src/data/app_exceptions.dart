class AppException implements Exception{

  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString(){

    return '$_prefix$_message';

  }

}

class FetchDataException extends AppException{

  FetchDataException([String? messages]) : super(messages, 'Error during Communication');

}

class BadRequestException extends AppException{

  BadRequestException([String? messages]) : super(messages, 'Invalid Request');

}

class UnauthorisedException extends AppException{

  UnauthorisedException([String? messages]) : super(messages, 'Unauthorised request');

}