import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/settings_models.dart';
import 'supabase_service.dart';

class SettingsService {
  SettingsService._();
  static final SettingsService instance = SettingsService._();

  static const _themeModeKey = 'theme_mode';
  static const _notificationsEnabledKey = 'notifications_enabled';

  SupabaseClient get _client => SupabaseService.instance.client;

  String _requireUserId() {
    final uid = SupabaseService.instance.currentUser?.id;
    if (uid == null || uid.isEmpty) {
      throw const _FriendlySettingsException('Oturum bulunamadı, lütfen tekrar giriş yapın');
    }
    return uid;
  }

  Future<UserProfile> getUserProfile() async {
    final uid = _requireUserId();
    final email = SupabaseService.instance.currentUser?.email ?? '';
    try {
      final row = await _client
          .from('users')
          .select('email,full_name')
          .eq('id', uid)
          .maybeSingle();

      final dbEmail = (row?['email'] as String?)?.trim();
      final fullName = (row?['full_name'] as String?)?.trim() ?? '';

      return UserProfile(
        userId: uid,
        email: (dbEmail != null && dbEmail.isNotEmpty) ? dbEmail : email,
        fullName: fullName,
      );
    } on SocketException {
      throw const _FriendlySettingsException('Bağlantı hatası, lütfen tekrar deneyin');
    } on PostgrestException {
      // If table/RLS isn't ready, fall back to auth data.
      return UserProfile(userId: uid, email: email, fullName: '');
    } catch (_) {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    }
  }

  Future<void> updateUserProfile({required String fullName}) async {
    final uid = _requireUserId();
    final next = fullName.trim();
    try {
      await _client.from('users').update({'full_name': next}).eq('id', uid);
    } on SocketException {
      throw const _FriendlySettingsException('Bağlantı hatası, lütfen tekrar deneyin');
    } on PostgrestException {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    } catch (_) {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    }
  }

  Future<List<String>> getDietaryPreferences() async {
    final uid = _requireUserId();
    try {
      final row = await _client
          .from('user_dietary_preferences')
          .select('preferences')
          .eq('user_id', uid)
          .maybeSingle();

      final prefs = row?['preferences'];
      if (prefs is List) {
        return prefs.map((e) => e.toString()).where((s) => s.trim().isNotEmpty).toSet().toList();
      }
      return const [];
    } on SocketException {
      throw const _FriendlySettingsException('Bağlantı hatası, lütfen tekrar deneyin');
    } on PostgrestException {
      return const [];
    } catch (_) {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    }
  }

  Future<void> saveDietaryPreferences(List<String> prefs) async {
    final uid = _requireUserId();
    final unique = prefs.map((e) => e.trim()).where((s) => s.isNotEmpty).toSet().toList();
    try {
      await _client.from('user_dietary_preferences').upsert({
        'user_id': uid,
        'preferences': unique,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on SocketException {
      throw const _FriendlySettingsException('Bağlantı hatası, lütfen tekrar deneyin');
    } on PostgrestException {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    } catch (_) {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    }
  }

  Future<PremiumStatus> getPremiumStatus() async {
    final uid = _requireUserId();
    try {
      final row = await _client
          .from('user_premium_status')
          .select('is_premium,premium_until')
          .eq('user_id', uid)
          .maybeSingle();

      final isPremium = (row?['is_premium'] as bool?) ?? false;
      final untilRaw = row?['premium_until'];
      DateTime? until;
      if (untilRaw is String && untilRaw.trim().isNotEmpty) {
        until = DateTime.tryParse(untilRaw);
      }
      return PremiumStatus(isPremium: isPremium, premiumUntil: until);
    } on SocketException {
      throw const _FriendlySettingsException('Bağlantı hatası, lütfen tekrar deneyin');
    } on PostgrestException {
      return PremiumStatus.none;
    } catch (_) {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    }
  }

  Future<void> mockPurchasePremium({required Duration duration}) async {
    final uid = _requireUserId();
    final until = DateTime.now().add(duration);
    try {
      await _client.from('user_premium_status').upsert({
        'user_id': uid,
        'is_premium': true,
        'premium_until': until.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on SocketException {
      throw const _FriendlySettingsException('Bağlantı hatası, lütfen tekrar deneyin');
    } on PostgrestException {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    } catch (_) {
      throw const _FriendlySettingsException('İşlem başarısız, lütfen tekrar deneyin');
    }
  }

  Future<void> logout() => SupabaseService.instance.signOut();

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_themeModeKey) ?? 'system';
    switch (v) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final v = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await prefs.setString(_themeModeKey, v);
  }

  Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, enabled);
  }
}

class _FriendlySettingsException implements Exception {
  final String message;
  const _FriendlySettingsException(this.message);
  @override
  String toString() => message;
}

