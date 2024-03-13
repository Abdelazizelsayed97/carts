class ApiError implements Exception {
  final int? code;
  final String? message;

  ApiError({
    this.code,
    this.message,
  });
}