import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double radius;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.radius = 24.0,
  });

  String _getInitial() {
    if (name != null && name!.trim().isNotEmpty) {
      return name!.trim()[0].toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final initial = _getInitial();

    Widget fallback() {
      return Center(
        child: Text(
          initial,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: radius * 0.9,
          ),
        ),
      );
    }

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.surfaceMuted,
        child: fallback(),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.surfaceMuted,
      child: ClipOval(
        child: Image.network(
          imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => fallback(),
        ),
      ),
    );
  }
}
