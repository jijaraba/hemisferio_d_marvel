import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:marvel_hemisferio/src/core/presentation/theme/theme.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/widgets.dart';
import 'package:marvel_hemisferio/src/core/res/res.dart';
import 'package:marvel_hemisferio/src/core/utils/common_extensions.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    return SplashScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VSpacing(10),
                Image.asset(Assets.hemisferioLogo),
                const VSpacing(300),
                Text(
                  localization.text("common.welcome"),
                  style: h1,
                  textAlign: TextAlign.center,
                ),
                const VSpacing(30),
                Text(
                  localization.text("common.welcome_content"),
                  style: textNormal,
                  textAlign: TextAlign.center,
                ),
                const VSpacing(80),
                CustomButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  text: "Continuar",
                  textColor: UIColors.white,
                  paddingHorizontal: 60,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
