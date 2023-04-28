import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  CredentialCubit() : super(CredentialInitial());
}
