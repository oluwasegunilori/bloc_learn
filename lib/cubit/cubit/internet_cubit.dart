import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_learn/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivitySubscriptionStream;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnetion();
  }

  void monitorInternetConnetion() {
    connectivitySubscriptionStream =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.ethernet) {
        emitInternetConnected(ConnectionType.Ethernet);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.bluetooth) {
        emitInternetConnected(ConnectionType.Bluetooth);
      } else {
        emitInternetDiconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDiconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivitySubscriptionStream.cancel();
    return super.close();
  }
}
