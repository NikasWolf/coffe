import 'package:flutter/material.dart';
import '../database/app_database.dart';

class BlogCard extends StatefulWidget {
  final BlogPost post;

  const BlogCard({super.key, required this.post});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  // Состояние: развернута ли карточка
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // При клике на карточку переключаем состояние
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF4E342E),
          borderRadius: BorderRadius.circular(12),
          // Добавим легкую рамку, чтобы было понятно, что на карточку можно нажать
          border: Border.all(color: _isExpanded ? Colors.amber : Colors.transparent, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Картинка
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                widget.post.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.article, size: 48, color: Colors.brown),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                },
              ),
            ),
            const SizedBox(width: 16),
            // Текст
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.post.date,
                    style: const TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  // Текст новости
                  Text(
                    widget.post.shortDescription,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    // Если развернуто (_isExpanded == true), maxLines = null (без ограничений)
                    // Если свернуто, maxLines = 3
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Маленькая подсказка внизу карточки
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _isExpanded ? 'Свернуть' : 'Читать далее...',
                        style: TextStyle(
                          color: Colors.amber.withValues(alpha: 0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.amber.withValues(alpha: 0.8),
                        size: 16,
                      ),
                    ],
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