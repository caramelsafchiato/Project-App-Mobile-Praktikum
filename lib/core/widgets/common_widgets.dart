import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const CustomErrorWidget({Key? key, required this.message, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: AppConstants.paddingLarge),
            ElevatedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text("Coba Lagi")),
          ]
        ],
      ),
    );
  }
}