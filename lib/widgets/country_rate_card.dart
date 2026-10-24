import 'package:flutter/material.dart';
import '../models/exchange_rate.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class CountryRateCard extends StatelessWidget {
  final ExchangeRate rate;
  final String baseCurrency;

  const CountryRateCard({
    super.key,
    required this.rate,
    this.baseCurrency = 'GBP',
  });

  String _formatRate(String val) {
    final parsed = double.tryParse(val);
    if (parsed == null) return val;
    if (parsed == 0) return '0.00';
    return parsed.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.xs + 2,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '1.00 $baseCurrency',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const Icon(
            Icons.sync_alt,
            size: 20,
            color: AppColors.textPrimary,
          ),
          Text(
            '${_formatRate(rate.rate)} ${rate.currencyCode}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
