// import 'package:flutter/material.dart';
// import 'package:geminai_realms/utils/constants/colors.dart';
// import 'package:geminai_realms/utils/constants/fonts.dart';
// import 'package:geminai_realms/utils/widgets/size_layout.dart';

// class AppTooltip extends StatelessWidget {
//   final SizeLayout size;
//   final String message;
//   final Widget child;

//   const AppTooltip(
//       {super.key,
//       required this.size,
//       required this.message,
//       required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Tooltip(
//       textStyle:
//           AppFonts.tooltip(size).copyWith(color: AppColors.tooltipForeground),
//       decoration: BoxDecoration(
//         color: AppColors.tooltipBackground,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       message: message,
//       child: child,
//     );
//   }
// }
