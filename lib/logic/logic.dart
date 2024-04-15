import 'package:crud_project/constants/snack_bar.dart';
import 'package:crud_project/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/service.dart';

abstract class LogicState {}

abstract class LogicEvent {}

class LogicInitializeState extends LogicState {}

class LogicErrorState extends LogicState {
  final String error;
  LogicErrorState({required this.error});
}

class LogicloadingState extends LogicState {}

class ReadUserState extends LogicState {
  final UserModel userModel;
  ReadUserState({required this.userModel});
}

class ReadUserEvent extends LogicEvent {}

class AddUserEvent extends LogicEvent {
  final String name;
  final BuildContext context;
  AddUserEvent({required this.name, required this.context});
}

class AddUserLoading extends LogicState {
  bool isLoading;
  AddUserLoading({required this.isLoading});
}

class UpdateUserEvent extends LogicEvent {
  final String id;
  final String name;
  final BuildContext context;
  UpdateUserEvent(this.context, {required this.id, required this.name});
}

class UpdateUserLoading extends LogicState {
  bool isLoading;
  UpdateUserLoading({required this.isLoading});
}

class DeleteUserEvent extends LogicEvent {
  final String id;
  DeleteUserEvent({required this.id});
}

class DeleteUserLoading extends LogicState {
  bool isLoading;
  DeleteUserLoading({required this.isLoading});
}

class LogicalService extends Bloc<LogicEvent, LogicState> {
  final RestApiService _service;
  LogicalService(this._service) : super(LogicInitializeState()) {
    on<AddUserEvent>((event, emit) async {
      emit(AddUserLoading(isLoading: true));
      await _service.addUserService(event.name).then((value) {
        emit(AddUserLoading(isLoading: false));
        /*Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });*/
        Navigator.pop(event.context);
      }).onError((error, stackTrace) {
        emit(AddUserLoading(isLoading: false));
      });
    });

    on<ReadUserEvent>((event, emit) async {
      emit(LogicloadingState());
      await _service.readUserService().then((value) {
        emit(ReadUserState(userModel: value));
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UpdateUserLoading(isLoading: true));
      //final Map<String, dynamic> data = {"id": event.id, "name": event.name};

      await _service.updateUserService(event.id, event.name).then((value) {
        emit(UpdateUserLoading(isLoading: false));
        snackBar(event.context, "User has been updated");
        /*Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });*/
        Navigator.pop(event.context);
      }).onError((error, stackTrace) {
        emit(UpdateUserLoading(isLoading: false));
      });
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(DeleteUserLoading(isLoading: true));
      await _service.deleteUserService(event.id).then((value) {
        emit(DeleteUserLoading(isLoading: false));
      }).onError((error, stackTrace) {
        emit(DeleteUserLoading(isLoading: false));
      });
    });
  }
}
