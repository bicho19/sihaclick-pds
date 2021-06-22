class ApiResult<T> {
  Status status;
  T data;
  String message;

  ApiResult.loading({this.message}) : status = Status.LOADING;

  ApiResult.completed({this.data}) : status = Status.COMPLETED;

  ApiResult.error({this.message}) : status = Status.ERROR;

  ApiResult.fieldsError({this.message, this.data})
      : status = Status.FIELDS_ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, FIELDS_ERROR }
