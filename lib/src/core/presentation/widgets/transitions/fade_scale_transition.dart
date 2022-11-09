part of core.presentation.widgets;

class FadeScaleTransition extends StatelessWidget {
  const FadeScaleTransition({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
    );
    return ScaleTransition(
      scale: scaleAnimation,
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
        child: child,
      ),
    );
  }
}
