import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../database/app_database.dart';

class StatsScreen extends StatefulWidget {
  final List<Order> orders;
  const StatsScreen({super.key, required this.orders});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    // 1. Считаем общую выручку
    final totalRevenue = widget.orders.fold(0.0, (sum, order) => sum + order.totalAmount);
    // 2. Считаем средний чек
    final avgCheck = widget.orders.isEmpty ? 0.0 : totalRevenue / widget.orders.length;
    // 3. Считаем количество заказов
    final totalOrders = widget.orders.length;

    // 4. Готовим данные для графика (группируем по датам)
    final Map<String, double> revenueByDate = {};
    for (var order in widget.orders) {
      revenueByDate[order.date] = (revenueByDate[order.date] ?? 0) + order.totalAmount;
    }
    // Сортируем даты по возрастанию
    final sortedDates = revenueByDate.keys.toList()..sort();
    // Берем последние 7 дней для графика
    final last7Days = sortedDates.length > 7 ? sortedDates.sublist(sortedDates.length - 7) : sortedDates;

    return Scaffold(
      backgroundColor: const Color(0xFF2D1B14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A110D),
        title: const Text('Статистика и аналитика', style: TextStyle(color: Colors.amber)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // КАРТОЧКИ С ОБЩИМИ ЦИФРАМИ
            Row(
              children: [
                _buildStatCard('Общая выручка', '${totalRevenue.toInt()} ₽', Icons.attach_money),
                const SizedBox(width: 16),
                _buildStatCard('Всего заказов', '$totalOrders', Icons.shopping_bag),
                const SizedBox(width: 16),
                _buildStatCard('Средний чек', '${avgCheck.toInt()} ₽', Icons.receipt),
              ],
            ),
            const SizedBox(height: 32),
            
            // ГРАФИК
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF3E2723),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Выручка за последние дни',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: last7Days.isEmpty 
                        ? const Center(child: Text('Нет данных для графика', style: TextStyle(color: Colors.white54)))
                        : BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: (revenueByDate.values.reduce((a, b) => a > b ? a : b) * 1.2),
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      '${rod.toY.toInt()} ₽\n',
                                      const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                          text: last7Days[group.x],
                                          style: const TextStyle(color: Colors.white70, fontSize: 10),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() >= 0 && value.toInt() < last7Days.length) {
                                        // Обрезаем год для красоты (оставляем только MM-DD)
                                        final dateStr = last7Days[value.toInt()].substring(5);
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(dateStr, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) => FlLine(color: Colors.white.withValues(alpha: 0.1), strokeWidth: 1),
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups: List.generate(last7Days.length, (index) {
                                final date = last7Days[index];
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: revenueByDate[date] ?? 0,
                                      color: Colors.amber,
                                      width: 24,
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF3E2723),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.amber, size: 28),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}