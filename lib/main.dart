import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:surf/src/redux/app_state.dart';
import 'package:surf/src/redux/store.dart';
import 'package:surf/src/services/router_service.dart';
import 'package:surf/src/theme/theme.dart';
import 'package:surf/src/screens/home/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_persist/redux_persist.dart';

import 'package:flutter/foundation.dart';
import 'package:surf/src/utils/file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(97, 216, 240, 1));

  final String storagePath = await getSurfApplicationDocumentsDirectory();
  final persistor = Persistor<AppState>(
    storage: FileStorage(File("$storagePath/state.json")),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true,
  );

  // Load initial state
  final initialState = await persistor.load();

  final store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState.initial(),
    middleware: [persistor.createMiddleware()],
    //middleware: [thunkMiddleware],
  );

  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  const App({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Surf with me',
        theme: ThemeStyle.lightTheme,
        home: const HomeScreen(),
        // onGenerateRoute: RouterService.generateRoute,
      ),
    );
  }
}
