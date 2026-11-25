import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Portrait extends StatelessWidget {
  final String url;
  final double size;
  final double radius;
  const Portrait({super.key, required this.url, this.size = 46, this.radius = 50});
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: SizedBox(
      width: size, height: size,
      child: url.isEmpty ? _fallback() : Image.network(
        url, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
        loadingBuilder: (context, child, progress) => progress == null ? child : _fallback(),
      ),
    ),
  );
  Widget _fallback() => Container(
    color: AppColors.iconCircleBg,
    alignment: Alignment.center,
    child: Icon(Icons.person_outline, size: size * .5, color: AppColors.bookingDetails),
  );
}
