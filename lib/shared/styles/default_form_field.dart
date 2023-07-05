// // ignore_for_file: unnecessary_null_in_if_null_operators
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
//
//
// class CustomTextFormField extends StatelessWidget {
//    TextEditingController controller;
//   final double width;
//   final String hintText;
//   final bool  enable;
//   final String labelText;
//   final ValueChanged<String> onChanged;
//   final String Function(String) validatorFun;
//   final int maxLines;
//   final TextInputType textInputType;
//   final bool isSecure;
//   final Color backgroundColor;
//   final Color textColor;
//   final Color borderColor;
//   final Color focusColor;
//   final Widget prefixIcon;
//   final Widget suffixIcon;
//   final InputBorder border;
//   final String initialValue;
//   final double borderRadius;
//
//
//   const CustomTextFormField(
//       {Key? key,
//       controller,
//       textInputType,
//       maxLines,
//       width,
//
//         enable,
//
//       this.hintText = "",
//       labelText,
//       onChanged,
//      required this. validatorFun,
//       this.isSecure = false,
//       this.backgroundColor = Colors.white,
//       this.textColor = Colors.black,
//       this.borderColor = Colors.grey,
//       focusColor,
//       prefixIcon,
//         suffixIcon,
//       border,
//       initialValue,
//       this.borderRadius = 15
//       })
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light); // 1
//     ThemeData theme = Theme.of(context);
//     //SizeConfig().init(context);
//     return Container(
//       //width: 325.w,
//       //height: 57.h,
//       decoration: BoxDecoration(
//         borderRadius : BorderRadius.circular(borderRadius ?? 15.r),
//         boxShadow : const [
//           BoxShadow(
//             color: Color.fromRGBO(90, 108, 234, 0.07000000029802322),
//             offset: Offset(12,26),
//             blurRadius: 50
//         )],
//         color : const Color.fromRGBO(255, 255, 255, 1),
//         border : Border.all(
//           color: const Color.fromRGBO(244, 244, 244, 1),
//           width: 1,
//         ),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: isSecure,
//         enabled: enable,
//         validator: validatorFun,
//
//         keyboardType: textInputType ?? TextInputType.text,
//         style: const TextStyle(
//             color: Color.fromRGBO(59, 59, 59, 1),
//             fontFamily: 'Regular',
//             fontSize: 14,
//             letterSpacing: 0.5,
//             fontWeight: FontWeight.normal,
//             height: 1
//         ),
//
//
//         cursorColor: Colors.grey,
//         maxLines: maxLines ?? 1,
//         onChanged: onChanged,
//         cursorHeight: 20,
//
//         initialValue: initialValue ?? null,
//         decoration: InputDecoration(
//           //contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//          //floatingLabelBehavior: FloatingLabelBehavior.auto,
//           //floatingLabelAlignment: FloatingLabelAlignment.center,
//           focusColor: focusColor ?? const Color.fromRGBO(254, 254, 255, 1),
//           fillColor: backgroundColor ?? const Color.fromRGBO(254, 254, 255, 1),
//           filled: true,
//           isDense: true,
//
//           prefixIcon: prefixIcon ?? null,
//           suffixIcon: suffixIcon ?? null,
//           labelText: labelText,
//           labelStyle: TextStyle(
//               fontSize: 14,
//               fontFamily: "Regular",
//               color: const Color(0xff3B3B3B).withOpacity(.3)
//           ),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             fontFamily: "Regular",
//             color: const Color(0xff3B3B3B).withOpacity(.3)
//           ),
//           // border: border ?? OutlineInputBorder(
//           //     borderRadius: BorderRadius.circular(borderRadius.r),
//           //     borderSide: const BorderSide(
//           //         color: Color(0xffF4F4F4),
//           //       width: 1.5,
//           //     )
//           // ),
//           enabledBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//           border: InputBorder.none,
//
//
// //           focusedBorder: border ?? OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(borderRadius.r),
// //               borderSide: const BorderSide(
// //                   color: Color(0xffF4F4F4),
// //
// //               )
// //           ),
// // errorMaxLines: 1,
// //           errorBorder: OutlineInputBorder(
// //             gapPadding: 0,
// //               borderRadius: BorderRadius.circular(15.r),
// //               borderSide: const BorderSide(
// //                   color: Color.fromRGBO(254, 254, 255, 1)60
// //               )
// //           ),
// //
// //           focusedErrorBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(15.r),
// //               borderSide: const BorderSide(
// //                   color: Color(0xffF4F4F4)
// //               )
// //           ),
//
//         ),
//       ),
//     );
//   }
// }
