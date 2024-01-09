import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeInterGray200 => theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.gray200,
      );
  static get bodyLargeInterOnPrimaryContainer =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodyLarge_1 => theme.textTheme.bodyLarge!;
  static get bodyLarge_2 => theme.textTheme.bodyLarge!;
  static get bodyMediumErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 14,
      );
  static get bodyMediumGray700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray700,
        fontSize: 14,
      );
  static get bodyMediumInter => theme.textTheme.bodyMedium!.inter;
  
  static get displaySmallOnPrimaryContainer =>
      theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  // Title text style
  static get titleLargeBlack90001 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeBlack90001Regular =>
      theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeGray50 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray50,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeGray90001 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray90001,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeInterBlack90001 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeInterOnPrimaryContainer =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeInterOnPrimaryContainerExtraBold =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w800,
      );
  static get titleLargeOnPrimaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeOnPrimaryContainerMedium =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeRegular => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLargeRegular_1 => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLargeSecondaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontWeight: FontWeight.w400,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleMediumMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      );
  static get titleMedium_1 => theme.textTheme.titleMedium!.copyWith(
    fontSize: 12
  );
}

extension on TextStyle {
  TextStyle get mada {
    return copyWith(
      fontFamily: 'Mada',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
