/// Result wrapper for API responses
class Result<T> {
  final T? _value;
  final Object? _error;

  Result.success(T value) : _value = value, _error = null;

  Result.error(Object error) : _value = null, _error = error;

  bool get isSuccess => _error == null;
  bool get isError => _error != null;

  T get value {
    if (isError) {
      throw StateError('Cannot get value from error result');
    }
    return _value as T;
  }

  Object get error {
    if (isSuccess) {
      throw StateError('Cannot get error from success result');
    }
    return _error!;
  }

  R when<R>({
    required R Function(T value) success,
    required R Function(Object error) error,
  }) {
    if (isSuccess) {
      return success(_value as T);
    } else {
      return error(_error!);
    }
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'Result.success($_value)';
    } else {
      return 'Result.error($_error)';
    }
  }
}
