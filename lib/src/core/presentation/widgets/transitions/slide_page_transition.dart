part of core.presentation.widgets;

class SlidePageTransition extends StatelessWidget {
  const SlidePageTransition({
    Key? key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final primaryTranslationAnimation = Tween<Offset>(
      begin: const Offset(300, 0),
      end: Offset.zero,
    ).animate(animation);

    final primaryFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animation);

    final secondaryTranslationAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(secondaryAnimation);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: primaryTranslationAnimation.value,
          child: Opacity(
            opacity: primaryFadeAnimation.value,
            child: child,
          ),
        );
      },
      child: AnimatedBuilder(
        animation: secondaryAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: secondaryTranslationAnimation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class SlidePageTransitionBuilder extends PageTransitionsBuilder {
  const SlidePageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlidePageTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}
