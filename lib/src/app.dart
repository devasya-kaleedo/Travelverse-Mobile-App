import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';
import 'package:travelverse_mobile_app/src/feedback/feedback_view.dart';
import 'package:travelverse_mobile_app/src/home/HomeScreen4.dart';
import 'package:travelverse_mobile_app/src/home/home_view.dart';
import 'package:travelverse_mobile_app/src/home/home_view_2.dart';
import 'package:travelverse_mobile_app/src/home/home_view_3.dart';
import 'package:travelverse_mobile_app/src/home/home_view_gpt.dart';
import 'package:travelverse_mobile_app/src/inclusions_exclusions/inclusions_exclusions.dart';
import 'package:travelverse_mobile_app/src/itinerary_detail/itinerary_detail_view.dart';
import 'package:travelverse_mobile_app/src/login/login_view.dart';
import 'package:travelverse_mobile_app/src/my_quotes/my_quotes_2.dart';
import 'package:travelverse_mobile_app/src/my_quotes/my_quotes_view.dart';
import 'package:travelverse_mobile_app/src/my_visa/visa_view.dart';
import 'package:travelverse_mobile_app/src/view_my_itineraries/view_my_itineraries.dart';
import 'package:travelverse_mobile_app/src/vouchers/vouchers_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelverse_mobile_app/src/vouchers/vouchers_view_2.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'home/home_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(
                fontFamily: 'Poppins',
                textTheme:
                    Theme.of(context).textTheme.apply(fontFamily: 'Poppins')),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            initialRoute: 'home',
            // home: Consumer<AuthProvider>(builder: (context, authState, _) {
            //   return authState.isAuthorized
            //       ? HomeView3()
            //       : FutureBuilder(
            //           future: authState.tryLogin(),
            //           builder: (context, snapshot) =>
            //               snapshot.connectionState == ConnectionState.waiting
            //                   ? CircularProgressIndicator()
            //                   : authState.isAuthorized
            //                       ? HomeView3()
            //                       : LoginView(),
            //         );
            // }),
            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            builder: (context, child) {
              return Consumer<AuthProvider>(builder: (context, authState, _) {
                return authState.isAuthorized
                    ? Overlay(
                        initialEntries: [
                          OverlayEntry(
                            builder: (context) => child!,
                          )
                        ],
                      )
                    : FutureBuilder(
                        future: authState.tryLogin(),
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                                ? CircularProgressIndicator()
                                : authState.isAuthorized
                                    ? Overlay(
                                        initialEntries: [
                                          OverlayEntry(
                                            builder: (context) => child!,
                                          )
                                        ],
                                      )
                                    : Overlay(initialEntries: [
                                        OverlayEntry(
                                          builder: (context) =>
                                              const LoginView(),
                                        )
                                      ]),
                      );
              });
            },
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case '/login':
                      return const LoginView();
                    case '/view_my_itineraries':
                      return ViewMyItineraries();
                    case '/my_quotes':
                      return MyQuotes2();
                    case '/itinerary_detail':
                      return ItineraryDetail();
                    case '/my_visa':
                      return VisaView();
                    case '/feedback':
                      return FeedbackView();
                    case '/vouchers':
                      return VouchersView2();
                    case '/inclusions_exclusions':
                      return InclusionsExclusionsView();
                    case '/home':
                      return HomeView3();
                    default:
                      return HomeView3();
                  }
                },
              );
            });
      },
    );
  }
}
