import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/http/timer_http.dart';
import 'package:quomia/models/crypto/balance.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/common/placeholder.dart';
import 'package:quomia/utils/route_observer.dart';

class CryptoStats extends StatefulWidget {
  const CryptoStats({super.key});

  @override
  State<CryptoStats> createState() => _CryptoStatsState();
}

class _CryptoStatsState extends State<CryptoStats> with RouteAware {
  bool _isLoading = true;
  Balance? _cryptoBalance;

  final HttpTimerService httpTimerService = HttpTimerService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _fetchCryptoBalance();
  }

  @override
  void didPopNext() {
    _fetchCryptoBalance();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _statsPlaceholder();
    }
    return _stats(_cryptoBalance);
  }

  Future<void> _fetchCryptoBalance() async {
    try {
      final response = await httpTimerService.fetchCryptoBalance();
      setState(() {
        _cryptoBalance = response;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _stats(Balance? cryptoBalance) {
    print('CryptoBalance: $cryptoBalance');
    if (cryptoBalance == null) {
      return _statsPlaceholder();
    }
    return _fullStats(cryptoBalance);
  }

  Widget _statsPlaceholder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        _walletWidgetPlaceholder(),
        const Gap(
          width: 10.0,
        ),
        _nftWidgetPlaceholder()
      ],
    );
  }

  Widget _fullStats(Balance balance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        _walletWidget(balance),
        const Gap(
          width: 10.0,
        ),
        _nftWidget(balance)
      ],
    );
  }

  Widget _walletWidgetPlaceholder() {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.light.primaryBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerPlaceholder(
                  width: 60,
                  height: 18,
                ),
                Gap(
                  height: 10.0,
                ),
                ShimmerPlaceholder(
                  width: 60,
                  height: 18,
                ),
                Gap(
                  height: 10.0,
                ),
                ShimmerPlaceholder(
                  width: 60,
                  height: 18,
                ),
                Gap(
                  height: 10.0,
                ),
                ShimmerPlaceholder(
                  width: 60,
                  height: 18,
                ),
                Gap(
                  height: 10.0,
                ),
                ShimmerPlaceholder(
                  width: 60,
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _walletWidget(Balance balance) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.light.primaryBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Label(
                  data: 'Saldo Portafoglio',
                  fontSize: 18,
                ),
                const Gap(
                  height: 10.0,
                ),
                const Label(
                  data: 'Saldo Disponibile',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                const Gap(
                  height: 10.0,
                ),
                Label(
                  data: balance.walletBalance,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.light.primary,
                ),
                const Gap(
                  height: 10.0,
                ),
                Label(
                  data: balance.priceBalance,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
                const Gap(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    text: balance.lossProfit,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.light.primaryText,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${balance.percentage}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.light.tertiary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nftWidget(Balance balance) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.light.primaryBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Label(
                  data: 'Collezione NFT',
                  fontSize: 18,
                ),
                const Gap(
                  height: 10.0,
                ),
                const Label(
                  data: 'Saldo della raccolta',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                const Gap(
                  height: 10.0,
                ),
                Label(
                  data: balance.nftsAmount,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.light.primary,
                ),
                const Gap(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Valore stimato: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.light.primaryText,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${balance.estimatedValue}',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: AppColors.light.primaryText,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nftWidgetPlaceholder() {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.light.primaryBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerPlaceholder(width: 60, height: 18),
                const Gap(
                  height: 10.0,
                ),
                const ShimmerPlaceholder(width: 60, height: 14),
                const Gap(
                  height: 10.0,
                ),
                const ShimmerPlaceholder(width: 60, height: 18),
                const Gap(
                  height: 10.0,
                ),
                const ShimmerPlaceholder(width: 60, height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
