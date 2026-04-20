import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static final SupabaseService instance = SupabaseService._();

  SupabaseClient get client => Supabase.instance.client;

  User? get currentUser => client.auth.currentUser;
  Session? get currentSession => client.auth.currentSession;

  Stream<AuthState> get onAuthStateChange => client.auth.onAuthStateChange;

  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final res = await client.auth.signUp(
        email: email,
        password: password,
        data: {
          if (fullName != null && fullName.trim().isNotEmpty)
            'full_name': fullName.trim(),
        },
      );
      return res;
    } on AuthException catch (e) {
      throw _toFriendlyException(e);
    } on SocketException {
      throw const FriendlyAuthException('Bağlantı hatası');
    } catch (_) {
      throw const FriendlyAuthException('Bir hata oluştu, lütfen tekrar deneyin');
    }
  }

  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw _toFriendlyException(e);
    } on SocketException {
      throw const FriendlyAuthException('Bağlantı hatası');
    } catch (_) {
      throw const FriendlyAuthException('Bir hata oluştu, lütfen tekrar deneyin');
    }
  }

  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } on SocketException {
      throw const FriendlyAuthException('Bağlantı hatası');
    } catch (_) {
      throw const FriendlyAuthException('Bir hata oluştu, lütfen tekrar deneyin');
    }
  }

  Future<void> resetPasswordForEmail(String email) async {
    try {
      await client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw _toFriendlyException(e);
    } on SocketException {
      throw const FriendlyAuthException('Bağlantı hatası');
    } catch (_) {
      throw const FriendlyAuthException('Bir hata oluştu, lütfen tekrar deneyin');
    }
  }

  Future<void> upsertUserProfile({
    required String userId,
    required String email,
    String? fullName,
  }) async {
    try {
      await client.from('users').upsert({
        'id': userId,
        'email': email,
        'full_name': fullName,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on PostgrestException catch (_) {
      // If RLS or migration isn't applied yet, don't block auth flow.
      return;
    } catch (_) {
      return;
    }
  }

  FriendlyAuthException _toFriendlyException(AuthException e) {
    final msg = (e.message).toLowerCase();

    if (msg.contains('invalid') && msg.contains('email')) {
      return const FriendlyAuthException('Geçersiz email adresi');
    }
    if (msg.contains('password') && (msg.contains('short') || msg.contains('6'))) {
      return const FriendlyAuthException('Şifre en az 6 karakter olmalı');
    }
    if (msg.contains('already') && (msg.contains('registered') || msg.contains('exists'))) {
      return const FriendlyAuthException('Bu email zaten kayıtlı');
    }
    if (msg.contains('invalid login') ||
        msg.contains('invalid credentials') ||
        msg.contains('invalid') && msg.contains('credentials')) {
      return const FriendlyAuthException('Email veya şifre yanlış');
    }

    return const FriendlyAuthException('Bir hata oluştu, lütfen tekrar deneyin');
  }
}

class FriendlyAuthException implements Exception {
  final String message;
  const FriendlyAuthException(this.message);

  @override
  String toString() => message;
}

