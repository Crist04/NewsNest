
enum ApiStatus {
  /// This status is used when the api is called and the response is not received yet.
  loading,

  /// This status is used when the api is called and the response is received successfully.
  success,

  /// This status is used when the api is called and the response is not received successfully.
  error,

  /// This status is used when the api is not called yet.
  initial
}
