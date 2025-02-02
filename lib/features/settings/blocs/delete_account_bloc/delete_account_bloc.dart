import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapidlie/config/data_state.dart';
import 'package:rapidlie/features/settings/repositories/delete_account_repository.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountRepository deleteAccoutRepository;
  DeleteAccountBloc({required this.deleteAccoutRepository})
      : super(DeleteAccountInitialState()) {
    on<SubmitDeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onDeleteAccount(
    SubmitDeleteAccountEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoadingState());
    try {
      final result = await deleteAccoutRepository.deleteAccount(
        email: event.email,
      );

      if (result is DataSuccess<String>) {
        emit(DeleteAccountSuccessState(message: result.data!));
      } else {
        emit(DeleteAccountErrorState(error: "Account deletion failed"));
      }
    } catch (e) {
      emit(DeleteAccountErrorState(error: e.toString()));
    }
  }
}
