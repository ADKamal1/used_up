// // ignore_for_file: use_key_in_widget_constructors, unnecessary_null_in_if_null_operators
//
// import 'package:flutter/material.dart';import 'package:flutter/services.dart';
//
//
// class DefaultButton extends StatelessWidget {
//   final String text;
//   final double width;
//   final double height;
//   final dynamic onTap;
//   final double borderRadius;
//   final double fontSize;
//   final Color bgColor;
//   final BoxBorder border;
//   final Color textColor;
//   final TextStyle textStyle;
//   const DefaultButton(
//       {this.text,
//         this.width,
//         this.height,
//         this.onTap,
//         this.borderRadius,
//         this.fontSize,
//         this.bgColor,
//         this.border,
//         this.textColor,
//         this.textStyle});
//   @override
//   Widget build(BuildContext context) {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light); // 1
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
//           color: bgColor ?? Color.fromRGBO(254, 254, 255, 1),
//           border: border ?? null,
//         ),
//         height: height ?? MediaQuery.of(context).size.height * 0.07,
//         width: width ?? double.infinity,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery
//                   .of(context)
//                   .size
//                   .width * 0.07),
//           child: Center(
//             child: Text(
//               text ?? '',
//               style: textStyle ??
//                   TextStyle(
//                     fontFamily: "BentonSans",
//                     //fontWeight: FontWeight.bold,
//                     color: textColor ?? Colors.black,
//                     fontSize: fontSize,
//                     //MediaQuery.of(context).size.width*0.3
//                   ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
//
// }
//
//
// //enum AniProps { width, height, color }
//
