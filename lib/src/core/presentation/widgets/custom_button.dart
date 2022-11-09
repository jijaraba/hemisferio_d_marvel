part of core.presentation.widgets;

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.background,
    this.onSurfaceColor,
    this.textColor,
    this.paddingHorizontal = 0,
    this.borderColor,
    this.isTextButton = false,
    this.textAlignRight = false,
    this.showBorder = false,
    this.icon,
    this.elevation = 2,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final Color? background;
  final Color? textColor;
  final double paddingHorizontal;
  final Color? borderColor;
  final Color? onSurfaceColor;
  final bool isTextButton;
  final bool textAlignRight;
  final bool showBorder;
  final Icon? icon;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ?? Container(),
        Text(
          text,
          style: textTheme.button!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: textColor ?? colorScheme.onPrimary,
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isTextButton)
            TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                primary: textColor ?? colorScheme.onPrimary,
              ),
              child: Align(
                alignment:
                !textAlignRight ? Alignment.center : Alignment.centerRight,
                child: child,
              ),
            )
          else
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(
                  side: borderColor != null
                      ? BorderSide(color: borderColor!)
                      : BorderSide.none,
                ),
                backgroundColor: background ?? colorScheme.primary,
                foregroundColor: textColor ?? colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                disabledBackgroundColor: onSurfaceColor ?? colorScheme.onSurface,
                elevation: elevation,
                minimumSize: const Size.fromHeight(50),
              ),
              child: child,
            ),
        ],
      ),
    );
  }
}
