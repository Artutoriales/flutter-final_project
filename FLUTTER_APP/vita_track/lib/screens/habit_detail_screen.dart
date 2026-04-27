import 'package:flutter/material.dart';

class HabitDetailScreen extends StatefulWidget {
  const HabitDetailScreen({super.key});

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  static const _green = Color(0xFF1D9E75);
  static const _greenDark = Color(0xFF085041);
  static const _greenLight = Color(0xFFE1F5EE);
  static const _greenMid = Color(0xFF5DCAA5);

  // Mock habit data
  final String _habitName = 'Water';
  final IconData _habitIcon = Icons.water_drop_outlined;
  final Color _habitColor = Color(0xFF378ADD);
  final Color _habitBg = Color(0xFFE6F1FB);
  final int _current = 6;
  final int _goal = 8;
  final String _unit = 'glasses';

  // Mock weekly data — 0.0 to 1.0 completion ratio per day
  final List<double> _weeklyData = [1.0, 0.75, 1.0, 0.5, 1.0, 1.0, 0.75];
  final List<String> _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final int _todayIndex = 6;

  // Mock monthly heatmap — 30 days
  final List<double> _monthData = [
    1.0, 0.5, 1.0, 0.0, 1.0, 1.0, 0.75,
    0.0, 1.0, 1.0, 0.5, 1.0, 0.0, 1.0,
    1.0, 1.0, 0.5, 1.0, 1.0, 0.0, 1.0,
    0.75, 1.0, 1.0, 0.5, 1.0, 1.0, 0.0,
    1.0, 0.75,
  ];

  int get _currentStreak => 5;
  int get _bestStreak => 12;
  int get _completedDays => _monthData.where((d) => d >= 1.0).length;
  int get _totalDays => _monthData.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _greenLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatsRow(),
                    const SizedBox(height: 20),
                    _buildSectionLabel("Today's progress"),
                    const SizedBox(height: 10),
                    _buildTodayCard(),
                    const SizedBox(height: 20),
                    _buildSectionLabel('This week'),
                    const SizedBox(height: 10),
                    _buildWeeklyChart(),
                    const SizedBox(height: 20),
                    _buildSectionLabel('This month'),
                    const SizedBox(height: 10),
                    _buildMonthHeatmap(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _green,
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 24),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _greenDark,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(_habitIcon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            _habitName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Goal: $_goal $_unit per day',
            style: const TextStyle(color: _greenMid, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard('Current streak', '$_currentStreak days', Icons.local_fire_department_outlined, const Color(0xFFD85A30)),
        const SizedBox(width: 10),
        _buildStatCard('Best streak', '$_bestStreak days', Icons.emoji_events_outlined, const Color(0xFFBA7517)),
        const SizedBox(width: 10),
        _buildStatCard('Completed', '$_completedDays/$_totalDays', Icons.check_circle_outline_rounded, _green),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFD3D1C7), width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _greenDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Color(0xFF888780)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayCard() {
    final progress = _current / _goal;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _greenMid, width: 0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_current of $_goal $_unit',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF085041),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _habitColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: _greenLight,
              valueColor: AlwaysStoppedAnimation<Color>(_habitColor),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLogButton(Icons.remove_rounded, 'Remove'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: _habitBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$_current',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: _habitColor,
                  ),
                ),
              ),
              _buildLogButton(Icons.add_rounded, 'Add'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogButton(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _habitBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _habitColor, size: 22),
        ),
      ),
    );
  }

  Widget _buildWeeklyChart() {
    const maxHeight = 80.0;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _greenMid, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_weekDays.length, (i) {
          final isToday = i == _todayIndex;
          final barH = (_weeklyData[i] * maxHeight).clamp(6.0, maxHeight);
          final color = _weeklyData[i] >= 1.0 ? _habitColor : _greenMid;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(_weeklyData[i] * 100).round()}%',
                style: TextStyle(
                  fontSize: 9,
                  color: isToday ? _greenDark : const Color(0xFF888780),
                  fontWeight: isToday ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 28,
                height: barH,
                decoration: BoxDecoration(
                  color: isToday ? _habitColor : color.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _weekDays[i],
                style: TextStyle(
                  fontSize: 11,
                  color: isToday ? _greenDark : const Color(0xFF888780),
                  fontWeight: isToday ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMonthHeatmap() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _greenMid, width: 0.5),
      ),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1,
            ),
            itemCount: _monthData.length,
            itemBuilder: (_, i) {
              final val = _monthData[i];
              Color cellColor;
              if (val == 0.0) {
                cellColor = const Color(0xFFF1EFE8);
              } else if (val < 1.0) {
                cellColor = _greenMid.withOpacity(0.5);
              } else {
                cellColor = _habitColor;
              }
              return Container(
                decoration: BoxDecoration(
                  color: cellColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLegendDot(const Color(0xFFF1EFE8), 'None'),
              const SizedBox(width: 10),
              _buildLegendDot(_greenMid.withOpacity(0.5), 'Partial'),
              const SizedBox(width: 10),
              _buildLegendDot(_habitColor, 'Done'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF888780))),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF085041),
      ),
    );
  }
}