import 'package:flutter/material.dart';
import '../models/exchange_rate.dart';
import '../models/login_response.dart';
import '../services/rate_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/country_rate_card.dart';
import '../widgets/loading_view.dart';
import '../widgets/profile_avatar.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  final UserData user;

  const DashboardScreen({super.key, required this.user});

  static const String routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RateService _rateService = RateService();
  late String _activeCountryId;

  bool _isLoading = true;
  String? _errorMessage;
  List<ExchangeRate> _rates = [];

  @override
  void initState() {
    super.initState();
    final payoutId = widget.user.payoutCountryId.trim();
    _activeCountryId = payoutId.isNotEmpty
        ? payoutId
        : (widget.user.countryID.trim().isNotEmpty
            ? widget.user.countryID.trim()
            : '6');
    _loadRates();
  }

  Future<void> _loadRates() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final payoutId = widget.user.payoutCountryId.trim();
    String targetId = payoutId.isNotEmpty
        ? payoutId
        : (widget.user.countryID.trim().isNotEmpty
            ? widget.user.countryID.trim()
            : '6');

    try {
      var result = await _rateService.fetchRates(
        token: widget.user.token,
        customerID: widget.user.customerID,
        clientID: widget.user.clientID,
        branchID: widget.user.branchID,
        countryID: targetId,
        fromCurrencyCode: widget.user.currencyID,
      );

      if (result.isEmpty && payoutId.isEmpty && targetId != '6') {
        targetId = '6';
        result = await _rateService.fetchRates(
          token: widget.user.token,
          customerID: widget.user.customerID,
          clientID: widget.user.clientID,
          branchID: widget.user.branchID,
          countryID: targetId,
          fromCurrencyCode: widget.user.currencyID,
        );
      }

      if (!mounted) return;
      setState(() {
        _activeCountryId = targetId;
        _rates = result;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Dashboard', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 22),
            tooltip: 'Refresh Rates',
            onPressed: _isLoading ? null : _loadRates,
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined, size: 22),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.textPrimary,
          onRefresh: _loadRates,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                    vertical: AppSpacing.sm,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.cardRadius,
                      ),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ProfileAvatar(
                              imageUrl: widget.user.customerProfileImage,
                              name: widget.user.fullName.isNotEmpty
                                  ? widget.user.fullName
                                  : widget.user.userName,
                              radius: 26,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.user.fullName.isNotEmpty
                                        ? widget.user.fullName
                                        : widget.user.userName,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.user.userName,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          child: Divider(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Wallet Currency',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.user.currencySign} ${widget.user.currencyCode}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.user.countryName,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textTertiary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 44,
                              width: 1,
                              color: AppColors.border,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Default Country',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'ID $_activeCountryId',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Country rates',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textTertiary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    AppSpacing.md,
                    AppSpacing.screenPadding,
                    AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      Text('Exchange Rates', style: theme.textTheme.titleLarge),
                      const Spacer(),
                      if (!_isLoading && _rates.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceMuted,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.pillRadius,
                            ),
                          ),
                          child: Text(
                            '${_rates.length} rates',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              _buildSliverRatesContent(theme),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverRatesContent(ThemeData theme) {
    if (_isLoading) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: LoadingView(message: 'Loading exchange rates...'),
      );
    }

    if (_errorMessage != null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.dangerSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 28,
                    color: AppColors.danger,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                OutlinedButton(
                  onPressed: _loadRates,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.pillRadius,
                      ),
                    ),
                  ),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_rates.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.currency_exchange,
                    size: 28,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'No exchange rates found',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Check back later for updated rates',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => CountryRateCard(
          rate: _rates[index],
          baseCurrency: widget.user.currencyCode.isNotEmpty
              ? widget.user.currencyCode
              : 'GBP',
        ),
        childCount: _rates.length,
      ),
    );
  }
}
