import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_app/core/supabase_client.dart';
import 'package:supabase_app/viewmodel/auth_view_model.dart';
import 'package:supabase_app/views/auth/login_view.dart';
import 'package:supabase_app/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseClientManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: .fromSeed(
                seedColor: Colors.lightGreen,
                brightness: Brightness.dark,
              ),
            ),
            home: auth.session != null ? HomeView() : LoginView(),
          );
        },
      ),
    );
  }
}
