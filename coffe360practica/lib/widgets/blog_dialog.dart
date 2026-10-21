import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BlogDialog extends StatefulWidget {
  final dynamic existingPost;
  const BlogDialog({super.key, this.existingPost});

  @override
  State<BlogDialog> createState() => _BlogDialogState();
}

class _BlogDialogState extends State<BlogDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingPost != null) {
      _titleController.text = widget.existingPost.title;
      _descController.text = widget.existingPost.shortDescription;
      _dateController.text = widget.existingPost.date;
      _imageController.text = widget.existingPost.imageUrl;
    } else {
      _dateController.text = '${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}';
      _imageController.text = 'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=200&auto=format&fit=crop';
    }
  }

  String _getMonthName(int month) {
    const months = ['января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'];
    return months[month - 1];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _dateController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.existingPost != null;

    return AlertDialog(
      backgroundColor: const Color(0xFF3E2723),
      title: Text(isEditing ? 'Редактировать новость' : 'Добавить новость', style: const TextStyle(color: Colors.amber)),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildField('Заголовок', _titleController),
              _buildField('Дата', _dateController),
              _buildField('Текст новости', _descController, maxLines: 5),
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
            final title = _titleController.text.trim();
            final desc = _descController.text.trim();
            final date = _dateController.text.trim();
            final image = _imageController.text.trim();

            if (title.isNotEmpty && desc.isNotEmpty) {
              Navigator.pop(context, {
                'title': title,
                'date': date,
                'shortDescription': desc,
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

  Widget _buildField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
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