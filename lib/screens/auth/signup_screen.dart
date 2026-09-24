import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../services/auth_service.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      await ref.read(authServiceProvider).signUpWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _nameController.text.trim(),
          );
      
      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        actions: [
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text('Log In'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppTheme.md),
              
              // App icon
              const Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppTheme.md),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.church,
                      size: 48,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  SizedBox(height: AppTheme.md),
                  Text(
                    'Join Faith Mission',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    'Start your journey of faith today',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.xxl),
              
              // Name field
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Email field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
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
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Password field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Confirm password field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
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
              
              // Terms and conditions
              RichText(
                text: TextSpan(
                  text: 'By signing up, you agree to our ',
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Sign up button
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
                    : const Text('Sign Up'),
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Divider
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.md),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Social signup buttons
              OutlinedButton.icon(
                onPressed: () async {
                  try {
                    setState(() => _isLoading = true);
                    await ref.read(authServiceProvider).signInWithGoogle();
                    if (mounted) context.go('/home');
                  } catch (e) {
                    setState(() {
                      _errorMessage = e.toString().replaceAll('Exception: ', '');
                    });
                  } finally {
                    setState(() => _isLoading = false);
                  }
                },
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Sign up with Google'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.mediumBorderRadius,
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.md),
              
              OutlinedButton.icon(
                onPressed: () async {
                  try {
                    setState(() => _isLoading = true);
                    await ref.read(authServiceProvider).signInWithApple();
                    if (mounted) context.go('/home');
                  } catch (e) {
                    setState(() {
                      _errorMessage = e.toString().replaceAll('Exception: ', '');
                    });
                  } finally {
                    setState(() => _isLoading = false);
                  }
                },
                icon: const Icon(Icons.apple),
                label: const Text('Sign up with Apple'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.mediumBorderRadius,
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.lg),
              
              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Log In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
