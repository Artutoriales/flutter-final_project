import 'package:flutter/material.dart';
import '../domain/routes/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _green = Color(0xFF1D9E75);
  static const _greenDark = Color(0xFF085041);
  static const _greenLight = Color(0xFFE1F5EE);
  static const _greenMid = Color(0xFF5DCAA5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _greenLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildHero(),
              const Spacer(flex: 3),
              _buildButtons(context),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.spa_outlined, color: Colors.white, size: 44),
        ),
        const SizedBox(height: 28),
        Text(
          'HabitFlow',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: _greenDark,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Build healthy habits,\none day at a time.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF0F6E56),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.login),
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Sign in',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.register),
            style: OutlinedButton.styleFrom(
              foregroundColor: _greenDark,
              side: const BorderSide(color: _greenMid, width: 1),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Create account',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
