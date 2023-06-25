import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class PageLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const PageLoader({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: isLoading,
          child: Positioned.fill(
            child: Container(
              color: lightContainer,
              child: const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
