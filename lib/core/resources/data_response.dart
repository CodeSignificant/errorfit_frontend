abstract class DataResponse<T> {
  final T? data;
  final String error;
  const DataResponse({this.data, this.error = "error not assigned"});
}

class DataSuccess<T> extends DataResponse<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataResponse<T> {
  const DataFailed(String error) : super(error: error);
}
