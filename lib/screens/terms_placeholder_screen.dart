import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Dummy terms page (no legal content yet).
class TermsPlaceholderScreen extends StatelessWidget {
  const TermsPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(l10n.authTermsOpen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          l10n.termsPlaceholderBody,
          style: const TextStyle(
            fontSize: 15,
            height: 1.5,
            color: Color(0xFF757575),
          ),
        ),
      ),
    );
  }
}
