import 'package:barber/features/auth/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/otp_view.dart';
import '../../features/home/views/home_view.dart';
import '../constants.dart';
import '../services/hive.dart';
import 'route_observer.dart';

const String homeView = '/home';
const String loginView = '/login';
const String otpView = '/otp';
const String signUpView = '/signUp';



class AppRouter {
  GoRouter getRouter({String? initialLocation}) {
    final token = HiveLocalStorage.instance.get(apiToken);
    final firstLogin = HiveLocalStorage.instance.get('firstLogin', defaultValue: 'false') == 'true';


    String determineInitialRoute() {
      if (token == null) {
        return loginView;
      } else if (firstLogin) {
        return signUpView;
      } else {
        return homeView;
      }
    }
    return GoRouter(
      initialLocation: determineInitialRoute(),
      debugLogDiagnostics: false,
      observers: [RouteLoggingObserver()],
      routes: [

        GoRoute(
          path: homeView,
          name: homeView,
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: loginView,
          name: loginView,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: otpView,
          name: otpView,
          builder: (context, state) {
            final phone = state.extra! as String;
            return OtpView(phone: phone);
          },
        ),
        GoRoute(
          path: signUpView,
          name: signUpView,
          builder: (context, state) {
            return SignUpView();
          },
        ),
        // GoRoute(
        //   path: subjectsView,
        //   name: subjectsView,
        //   builder: (context, state) {
        //     final data = state.extra! as Map<String, dynamic>;
        //     return  SubjectsView(
        //       title: data['title'],
        //       subjects: data['subjects'],
        //
        //     );
        //   },
        // ),

        // GoRoute(
        //   path: upholsteryProductsView,
        //   name: upholsteryProductsView,
        //   builder: (context, state) {
        //     //final UpholsterSubCategory value = state.extra as UpholsterSubCategory;
        //     return UpholsteryProductsView(
        //         id: state.uri.queryParameters['id'] ?? '');
        //   },
        // ),

      ],

      errorPageBuilder: (context, state) {
        return MaterialPage(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('No Route Found'),
            ),
            body: const Center(child: Text('No Route Found')),
          ),
        );
      },
    );
  }
}


// class DynamicCodec extends Codec<Object?, Object?> {
//   const DynamicCodec();
//
//   @override
//   Converter<Object?, Object?> get decoder => const DynamicDecoder();
//
//   @override
//   Converter<Object?, Object?> get encoder => const DynamicEncoder();
// }
//
// class DynamicDecoder extends Converter<Object?, Object?> {
//   const DynamicDecoder();
//
//   @override
//   Object? convert(Object? input) {
//     if (input == null) return null;
//     if (input is String) {
//       return jsonDecode(input) as Map<String, dynamic>; // Decode JSON string into a Map
//     }
//     throw FormatException('Unable to decode input: $input');
//   }
// }
//
// class DynamicEncoder extends Converter<Object?, Object?> {
//   const DynamicEncoder();
//
//   @override
//   Object? convert(Object? input) {
//     if (input == null) return null;
//     // Encode any object into a JSON string
//     try {
//       return jsonEncode(input);
//     } catch (e) {
//       throw FormatException('Cannot encode type ${input.runtimeType}');
//     }
//   }
// }
