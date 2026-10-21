import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class CoffeeDialog extends StatefulWidget {
  final dynamic existingCoffee; // Передаем Coffee из базы или null
  const CoffeeDialog({super.key, this.existingCoffee});

  @override
  State<CoffeeDialog> createState() => _CoffeeDialogState();
}

class _CoffeeDialogState extends State<CoffeeDialog> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingCoffee != null) {
      _nameController.text = widget.existingCoffee.name;
      _priceController.text = widget.existingCoffee.price.toInt().toString();
      _descController.text = widget.existingCoffee.description;
      _imageController.text = widget.existingCoffee.imageUrl;
    } else {
      // Дефолтная картинка для новых товаров
      _imageController.text = 'https://images.unsplash.com/photo-1510707577719-ae7c14805e3a?q=80&w=200&auto=format&fit=crop';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.existingCoffee != null;

    return AlertDialog(
      backgroundColor: const Color(0xFF3E2723),
      title: Text(isEditing ? 'Редактировать кофе' : 'Добавить кофе', style: const TextStyle(color: Colors.amber)),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildField('Название напитка', _nameController),
              _buildField('Цена (₽)', _priceController, isNumber: true),
              _buildField('Состав', _descController, maxLines: 3),
                            Row(
                children: [
                  Expanded(child: _buildField('Путь к картинке', _imageController)),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final PlatformFile? file = await FilePicker.pickFile(type: FileType.image);
                        if (file != null && file.path != null) {
                          _imageController.text = file.path!;
                        }
                     },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Выбрать файл'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена', style: TextStyle(color: Colors.white54)),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text.trim();
            final price = double.tryParse(_priceController.text) ?? 0.0;
            final desc = _descController.text.trim();
            final image = _imageController.text.trim();

            if (name.isNotEmpty && desc.isNotEmpty) {
              Navigator.pop(context, {
                'name': name,
                'price': price,
                'description': desc,
                'imageUrl': image,
              });
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black.withValues(alpha: 0.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}