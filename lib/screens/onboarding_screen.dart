import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onDone;

  const OnboardingScreen({super.key, required this.onDone});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _slideVisuals = [
    (
      emoji: '🥗',
      bgGradient: [Color(0xFF00ACC1), Color(0xFF00838F)],
    ),
    (
      emoji: '👨‍🍳',
      bgGradient: [Color(0xFF26A69A), Color(0xFF00695C)],
    ),
    (
      emoji: '🛒',
      bgGradient: [Color(0xFF00ACC1), Color(0xFF0097A7)],
    ),
  ];

  void _goNext() {
    if (_currentPage < _slideVisuals.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onDone();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  (String title, String subtitle) _texts(AppLocalizations l10n, int index) {
    switch (index) {
      case 0:
        return (l10n.onboarding1Title, l10n.onboarding1Body);
      case 1:
        return (l10n.onboarding2Title, l10n.onboarding2Body);
      case 2:
        return (l10n.onboarding3Title, l10n.onboarding3Body);
      default:
        return ('', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLast = _currentPage == _slideVisuals.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!isLast)
                      TextButton(
                        onPressed: widget.onDone,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF9E9E9E),
                        ),
                        child: Text(
                          l10n.skip,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slideVisuals.length,
                itemBuilder: (context, index) {
                  final v = _slideVisuals[index];
                  final t = _texts(l10n, index);
                  return _SlidePage(
                    emoji: v.emoji,
                    bgGradient: v.bgGradient,
                    title: t.$1,
                    subtitle: t.$2,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slideVisuals.length,
                      (i) => _Dot(active: i == _currentPage),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goNext,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLast ? l10n.letsGo : l10n.continueButton,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            isLast
                                ? Icons.check_rounded
                                : Icons.arrow_forward_rounded,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  final String emoji;
  final List<Color> bgGradient;
  final String title;
  final String subtitle;

  const _SlidePage({
    required this.emoji,
    required this.bgGradient,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: bgGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 96),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: -0.6,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9E9E9E),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;

  const _Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF00ACC1) : const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
