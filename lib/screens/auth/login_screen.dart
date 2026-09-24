import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../services/auth_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      await ref.read(authServiceProvider).signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
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
        title: const Text('Log In'),
        actions: [
          TextButton(
            onPressed: () => context.go('/signup'),
            child: const Text('Sign Up'),
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
                    'Welcome Back',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    'Log in to continue your faith journey',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.xxl),
              
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
                textInputAction: TextInputAction.done,
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
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
              
              const SizedBox(height: AppTheme.sm),
              
              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go('/forgot-password'),
                  child: const Text('Forgot Password?'),
                ),
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
              
              // Login button
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
                    : const Text('Log In'),
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
              
              // Social login buttons
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
                label: const Text('Continue with Google'),
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
                label: const Text('Continue with Apple'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.mediumBorderRadius,
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.lg),
              
              // Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => context.go('/signup'),
                    child: const Text('Sign Up'),
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
