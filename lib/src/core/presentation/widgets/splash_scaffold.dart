part of core.presentation.widgets;

class SplashScaffold extends StatelessWidget {
  const SplashScaffold({
    required this.body,
    this.resizeToAvoidBottomInset,
    this.backgroundImage = Assets.background,
    Key? key,
  }) : super(key: key);

  final bool? resizeToAvoidBottomInset;
  final String backgroundImage;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SplashBackground(
        image: backgroundImage,
        child: body,
      ),
    );
  }
}

class SplashBackground extends StatelessWidget {
  const SplashBackground({
    required this.child,
    Key? key,
    this.image = Assets.background,
  }) : super(key: key);

  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
            color: UIColors.black.withOpacity(0.1),
            colorBlendMode: BlendMode.luminosity,
          ),
          child,
        ],
      ),
    );
  }
}
