import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {

  final Widget child;

  const FormContainer({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final formShape = BoxDecoration(
      color:  Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset: Offset(0,5)
        )
      ]
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: formShape,
        child: child
      ),
    );
  }

}