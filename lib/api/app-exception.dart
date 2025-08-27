class AppException implements Exception{
  String message;
  AppException({required this.message});
  @override
  String toString() {
    // TODO: implement toString
    return "AppException:${message}";

  }
}