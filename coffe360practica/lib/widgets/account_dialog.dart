import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:drift/drift.dart' hide Column;

class AccountDialog extends StatefulWidget {
  const AccountDialog({super.key});

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  late TextEditingController _nameController;
  late TextEditingController _loginController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _loginController = TextEditingController(text: user?.login ?? '');
    _addressController = TextEditingController(text: user?.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _loginController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();
    final user = auth.currentUser;

    return AlertDialog(
      backgroundColor: const Color(0xFF3E2723),
      title: const Text('Настройки аккаунта', style: TextStyle(color: Colors.amber)),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Имя', _nameController),
              _buildTextField('Логин', _loginController), // Логин лучше не менять, оставим для вида
              _buildTextField('Адрес доставки', _addressController),
            ],
          ),
        ),
      ),
      actions: [
        // Кнопка выхода
        TextButton.icon(
          onPressed: () {
            auth.logout();
            Navigator.pop(context); // Закрываем диалог
          },
          icon: const Icon(Icons.logout, color: Colors.redAccent),
          label: const Text('Выйти', style: TextStyle(color: Colors.redAccent)),
        ),
        const Spacer(), // Прижимает следующие кнопки вправо
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена', style: TextStyle(color: Colors.white54)),
        ),
        ElevatedButton(
          onPressed: () {
            if (user != null) {
              // Обновляем данные
              final updatedUser = user.copyWith(
                name: _nameController.text.trim(),
                address: Value(_addressController.text.trim()),
              );
              auth.updateProfile(updatedUser);
            }
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black.withValues(alpha: 0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}