import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/form.dart';
import '../../components/input.dart';
import '../../components/button.dart';
import '../../theme/fpdui_theme.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  
  String? _usernameError;

  void _submit() {
    setState(() {
      if (_usernameController.text.length < 2) {
        _usernameError = 'Username must be at least 2 characters.';
      } else {
        _usernameError = null;
        // Proceed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form Example', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(8),
            const Text('A manual validation example simulating standard form behavior.', style: TextStyle(color: Colors.grey)),
            const Gap(24),
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FpduiFormItem(
                    label: 'Username',
                    description: 'This is your public display name.',
                    error: _usernameError,
                    child: FpduiInput(
                      controller: _usernameController,
                      hintText: 'shadcn',
                    ),
                  ),
                  const Gap(24),
                  FpduiButton(
                    text: 'Submit',
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
