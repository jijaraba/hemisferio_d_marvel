part of core.presentation.theme;

final ShapeBorder shapeSmall = RoundedRectangleBorder(
  borderRadius: borderRadiusSmall,
);

final ShapeBorder shapeMedium = RoundedRectangleBorder(
  borderRadius: borderRadiusMedium,
);

final ShapeBorder shapeLarge = RoundedRectangleBorder(
  borderRadius: borderRadiusLarge,
);

final ShapeBorder shapeXLarge = RoundedRectangleBorder(
  borderRadius: borderRadiusXLarge,
);

final BorderRadius borderRadiusSmall = BorderRadius.circular(10);

final BorderRadius borderRadiusMedium = BorderRadius.circular(10);

final BorderRadius borderRadiusLarge = BorderRadius.circular(30);

final BorderRadius borderRadiusXLarge = BorderRadius.circular(35);

BoxShadow shadow3Y6B = BoxShadow(
  color: UIColors.black16,
  offset: const Offset(0, 3),
  blurRadius: 6,
);

BoxShadow shadowStrong3Y6B = BoxShadow(
  color: UIColors.black36,
  offset: const Offset(0, 3),
  blurRadius: 6,
);
