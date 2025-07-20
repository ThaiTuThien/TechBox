import 'package:flutter/material.dart';

class InputComponent extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final String? errorText;
  final bool isSuccess;
  final TextInputType keyboardType;

  const InputComponent({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.errorText,
    this.isSuccess = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  late bool obscureHide;

  @override
  void initState() {
    super.initState();
    obscureHide = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor =
        widget.errorText != null
            ? Colors.red
            : widget.isSuccess
            ? Colors.green
            : Color(0xFF999999);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        TextField(
          controller: widget.controller,
          obscureText: obscureHide,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
            suffixIcon:
                widget.obscureText
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureHide = !obscureHide;
                        });
                      },
                      icon: Icon(
                        obscureHide
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    )
                    : widget.errorText != null
                    ? Icon(Icons.error_outline_rounded, color: Colors.red)
                    : widget.isSuccess
                    ? Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.green,
                    )
                    : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 6, left: 4),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
