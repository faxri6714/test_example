import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String?)? onChange;
  final Function(String?)? onSubmit;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
      this.onChange,
      this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: TextFormField(
          controller: controller,
          onChanged: onChange,
          onFieldSubmitted: onSubmit,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 1,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 2,
                )),
          ),
        ),
      ),
    );
  }
}
