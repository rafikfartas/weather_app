import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  const CustomContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 0),
              color: Colors.black.withOpacity(0.01),
              blurRadius: 010,
            ),
            BoxShadow(
              offset: const Offset(-3, 0),
              color: Colors.black.withOpacity(0.01),
              blurRadius: 010,
            ),
            BoxShadow(
              offset: const Offset(0, -3),
              color: Colors.black.withOpacity(0.01),
              blurRadius: 010,
            ),
            BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.01),
              blurRadius: 010,
            ),
          ]),
      width: double.maxFinite,
      child: child,
    );
  }
}
