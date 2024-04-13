import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  final String? hintText;
  final Function(String)? onChanged;
  bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Valid is required';
        }
        // Return null if the input is valid
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        // Use the suffixIcon variable here
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    Key? key,
    this.hintText,
    this.onChanged,
    required this.obscureText,
  }) : super(key: key);

  final String? hintText;
  final Function(String)? onChanged;
  bool obscureText;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Valid is required';
        }
      },
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.obscureText = !widget.obscureText;
            });
          },
          icon: Icon(
            widget.obscureText ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
