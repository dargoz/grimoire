enum Status { initial, loading, completed, error }

class Resource<T> {
  final Status status;
  final T? data;
  final String? message;
  final String? errorCode;

  const Resource.initial(this.message, {this.data, this.errorCode})
      : status = Status.initial;

  const Resource.loading(this.message, {this.data, this.errorCode})
      : status = Status.loading;

  const Resource.completed(this.data, {this.message, this.errorCode})
      : status = Status.completed;

  const Resource.error(this.message, {this.data, this.errorCode})
      : status = Status.error;
}
