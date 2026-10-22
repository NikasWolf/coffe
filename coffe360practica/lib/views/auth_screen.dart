import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isRegistering = false;
  String? _errorMessage;

    @override
    void initState() {
      super.initState();
      // ВОТ ЭТИ ТРИ СТРОКИ СЛЕДЯТ ЗА ТЕКСТОМ:
      _loginController.addListener(_clearError);
      _passwordController.addListener(_clearError);
      _nameController.addListener(_clearError);
    }

    @override
    void dispose() {
      _loginController.dispose();
      _passwordController.dispose();
      _nameController.dispose();
      super.dispose();
    }

    // А ЭТОТ МЕТОД СТИРАЕТ ОШИБКУ, КОГДА ТЫ ПЕЧАТАЕШЬ
    void _clearError() {
      if (_errorMessage != null) {
        setState(() {
          _errorMessage = null;
        });
      }
    }

    void _submit() async {
    // 1. Очищаем старую ошибку при КАЖДОМ нажатии на кнопку
    setState(() {
      _errorMessage = null;
    });

    final authVM = context.read<AuthViewModel>();
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    // Проверка на пустые поля
    if (login.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Заполните все поля');
      return;
    }

    String? error;
    if (_isRegistering) {
      if (_nameController.text.trim().isEmpty) {
        setState(() => _errorMessage = 'Введите имя');
        return;
      }
      error = await authVM.register(_nameController.text.trim(), login, password);
    } else {
      error = await authVM.login(login, password);
    }

    // 2. Если после запроса появилась ошибка — показываем её
    if (error != null && mounted) {
      setState(() => _errorMessage = error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D1B14),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFF3E2723),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.coffee, color: Colors.amber, size: 64),
              const SizedBox(height: 16),
              Text(
                _isRegistering ? 'Регистрация' : 'Вход в систему',
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              
              if (_isRegistering) ...[
                _buildField('Ваше имя', _nameController),
                const SizedBox(height: 12),
              ],
              _buildField('Логин', _loginController),
              const SizedBox(height: 12),
              _buildField('Пароль', _passwordController, obscure: true),
              
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent)),
              ],
              
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(_isRegistering ? 'Зарегистрироваться' : 'Войти', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isRegistering = !_isRegistering;
                    _errorMessage = null;
                  });
                },
                child: Text(
                  _isRegistering ? 'Уже есть аккаунт? Войти' : 'Нет аккаунта? Зарегистрироваться',
                  style: const TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
}