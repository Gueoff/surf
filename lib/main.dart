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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(97, 216, 240, 1));
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [],
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
