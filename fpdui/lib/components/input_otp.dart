// Responsible for capturing one-time passwords or verification codes.
// Provides FpduiInputOTP, InputOTPGroup, InputOTPSlot, InputOTPSeparator.
//
// Used by: Auth screens, verification flows.
// Depends on: fpdui_theme.
// Assumes: Fixed length numeric input.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

class FpduiInputOTP extends StatefulWidget {
  const FpduiInputOTP({
    super.key,
    required this.maxLength,
    required this.onChanged,
    this.initialValue = '',
    this.children, // Custom layout
  });

  final int maxLength;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final List<Widget>? children; 

  @override
  State<FpduiInputOTP> createState() => _FpduiInputOTPState();
}

class _FpduiInputOTPState extends State<FpduiInputOTP> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(_onChange);
  }

  void _onChange() {
    widget.onChanged(_controller.text);
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If no custom children are provided, create default slots
    final displayWidgets = widget.children ?? [
      FpduiInputOTPGroup(
        children: List.generate(widget.maxLength, (index) {
          return FpduiInputOTPSlot(
            index: index, 
            char: index < _controller.text.length ? _controller.text[index] : null,
            isActive: _focusNode.hasFocus && (index == _controller.text.length || (index == widget.maxLength - 1 && _controller.text.length == widget.maxLength)),
          );
        }),
      )
    ];

    return Stack(
      children: [
        // Hidden input
        SizedBox(
          width: 0,
          height: 0,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            maxLength: widget.maxLength,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
          ),
        ),
        // Visible slots
        GestureDetector(
          onTap: () {
             _focusNode.requestFocus();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: displayWidgets,
          ),
        ),
      ],
    );
  }
}

class FpduiInputOTPGroup extends StatelessWidget {
  const FpduiInputOTPGroup({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class FpduiInputOTPSlot extends StatelessWidget {
  const FpduiInputOTPSlot({
    super.key,
    required this.index,
    this.char,
    this.isActive = false,
  });

  final int index;
  final String? char;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      width: 40, // 10 * 4
      height: 40,
      alignment: Alignment.center, // justify-center items-center
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
           top: BorderSide(color: isActive ? fpduiTheme.ring : fpduiTheme.input, width: isActive ? 2 : 1),
           bottom: BorderSide(color: isActive ? fpduiTheme.ring : fpduiTheme.input, width: isActive ? 2 : 1),
           left: BorderSide(color: isActive ? fpduiTheme.ring : fpduiTheme.input, width: isActive ? 2 : 1),
           right: BorderSide(color: isActive ? fpduiTheme.ring : fpduiTheme.input, width: isActive ? 2 : 1),
        ),
        // Logic for connecting borders (not implemented fully for simplicity, just boxes for now)
      ),
      child: Text(
        char ?? '',
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}

class FpduiInputOTPSeparator extends StatelessWidget {
  const FpduiInputOTPSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text("-"), // Dot or dash
    );
  }
}
