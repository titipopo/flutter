part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState.unknown() : this._();

  const RegisterState.processing()
      : this._(status: DataResponseStatus.processing);

  const RegisterState.done()
      : this._(
          status: DataResponseStatus.success,
        );

  const RegisterState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  const RegisterState._({
    this.message,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;

  @override
  List<Object?> get props => [status, message];
}
