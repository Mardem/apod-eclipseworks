class AppResponse<T> {
  AppResponse({
    required this.success,
    required this.response,
  });

  final bool success;
  final T? response;
}
