import 'package:flutter/material.dart';
import '../main_shell/main_shell_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MainShellScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF355E4B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xFFF3EFE4),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logo/splash_logo.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'BeritaKita',
              style: TextStyle(
                color: Color(0xFFF3EFE4),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Berita hari ini, lebih dekat.',
              style: TextStyle(
                color: Color(0xFFE4EBDD),
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 12),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LoadingDot(),
                SizedBox(width: 4),
                _LoadingDot(),
                SizedBox(width: 4),
                _LoadingDot(),
              ],
            ),

            const SizedBox(height: 8),

            const Text(
              'MEMUAT BERITA...',
              style: TextStyle(
                color: Color(0xFFE4EBDD),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingDot extends StatelessWidget {
  const _LoadingDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: const BoxDecoration(
        color: Color(0xFFF3EFE4),
        shape: BoxShape.circle,
      ),
    );
  }
}
