import 'package:flutter/material.dart';
import 'dart:io'; // <-- ОБЯЗАТЕЛЬНО для работы с файлами
import '../database/app_database.dart';

class BlogCard extends StatefulWidget {
  final BlogPost post;

  const BlogCard({super.key, required this.post});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          border: Border.all(color: _isExpanded ? Colors.amber : Colors.transparent, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Картинка с проверкой (Файл или Сеть)
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: widget.post.imageUrl.startsWith('http')
                  ? Image.network(
                      widget.post.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.article, size: 48, color: Colors.brown),
                      ),
                    )
                  : File(widget.post.imageUrl).existsSync()
                      ? Image.file(
                          File(widget.post.imageUrl),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(Icons.article, size: 48, color: Colors.brown),
                          ),
                        )
                      : const Center(child: Icon(Icons.article, size: 48, color: Colors.brown)),
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
                  Text(
                    widget.post.shortDescription,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
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