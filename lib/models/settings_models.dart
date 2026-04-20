class UserProfile {
  final String userId;
  final String email;
  final String fullName;

  const UserProfile({
    required this.userId,
    required this.email,
    required this.fullName,
  });

  UserProfile copyWith({String? email, String? fullName}) {
    return UserProfile(
      userId: userId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }
}

class PremiumStatus {
  final bool isPremium;
  final DateTime? premiumUntil;

  const PremiumStatus({
    required this.isPremium,
    required this.premiumUntil,
  });

  static const none = PremiumStatus(isPremium: false, premiumUntil: null);
}

