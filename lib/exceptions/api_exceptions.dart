class ApiExceptions implements Exception {
  String? message;

  ApiExceptions([this.message = 'Something went wrong']) {
    message = 'Api exception $message';
  }

  @override
  String toString() {
    return message ?? "";
  }
}
