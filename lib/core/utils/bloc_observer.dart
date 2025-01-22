import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_log.dart';

class CustomBlocObserver extends BlocObserver {

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogs().debugLog('🟢 ${bloc.runtimeType} (onCreate)');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (change.nextState.runtimeType.toString().contains('Failed')) {
      AppLogs().errorLog('🔴 ${bloc.runtimeType} (onChange): '
          '${change.currentState.runtimeType} ==> ${change.nextState.runtimeType}');
    } else {
      AppLogs().debugLog('🔄 ${bloc.runtimeType} (onChange): '
          '${change.currentState.runtimeType} ==> ${change.nextState.runtimeType}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogs().errorLog('🚨 ${bloc.runtimeType} (onError): $error', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogs().warningLog('⚠️ ${bloc.runtimeType} (onClose)');
  }
}
