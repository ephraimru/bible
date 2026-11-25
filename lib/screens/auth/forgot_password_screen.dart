import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../services/auth_service.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  
  bool _isLoading = false;
  bool _emailSent = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      await ref.read(authServiceProvider).resetPassword(
            _emailController.text.trim(),
          );
      
      setState(() {
        _emailSent = true;
      });
    } catch (e) {
      if (mounted) setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: _emailSent
            ? _buildSuccessView(context)
            : _buildForgotPasswordForm(context),
      ),
    );
  }

  Widget _buildForgotPasswordForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppTheme.md),
          
          // App icon
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppTheme.md),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_reset,
                  size: 48,
                  color: AppTheme.primaryColor,
                ),
              ),
              SizedBox(height: AppTheme.md),
              Text(
                'Reset Your Password',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                'Enter your email to receive a reset link',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.xxl),
          
          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onFieldSubmitted: (_) => _submit(),
          ),
          
          // Error message
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: AppTheme.sm),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          
          const SizedBox(height: AppTheme.md),
          
          // Reset button
          ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
              shape: RoundedRectangleBorder(
                borderRadius: AppTheme.mediumBorderRadius,
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : const Text('Send Reset Link'),
          ),
          
          const SizedBox(height: AppTheme.md),
          
          // Remember password
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Remember your password?'),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Log In'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppTheme.xxl),
        
        // Success icon
        Container(
          padding: const EdgeInsets.all(AppTheme.xxl),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 64,
            color: Colors.green,
          ),
        ),
        
        const SizedBox(height: AppTheme.xl),
        
        // Success message
        Text(
          'Reset Link Sent',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.green,
              ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: AppTheme.md),
        
        Text(
          'If an account exists for that email, we have sent it a link to reset '
          'your password. Check your inbox and spam folder.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: AppTheme.xxl),
        
        // Back to login button
        ElevatedButton(
          onPressed: () => context.go('/login'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
            shape: RoundedRectangleBorder(
              borderRadius: AppTheme.mediumBorderRadius,
            ),
          ),
          child: const Text('Back to Login'),
        ),
      ],
    );
  }
}
