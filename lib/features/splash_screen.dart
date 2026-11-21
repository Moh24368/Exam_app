import 'package:exam/config/routes/page_routes_name.dart';
import 'package:exam/config/storage/shared_preferences.dart';
import 'package:exam/core/constants/app_images.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final results = await Future.wait([
      SharedPreferencesHelper.getToken(),
      Future.delayed(const Duration(seconds: 3)),
    ]);

    final token = results.first as String?;
    final isLoggedIn = token != null && token.isNotEmpty;

    if (!mounted) return;
    context.goNamed(isLoggedIn ? PageRoutesName.home : PageRoutesName.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.profit),
      ),
    );
  }
}