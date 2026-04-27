import 'package:flutter/material.dart';
import '../../domain/routes/router.dart';

class HabitModel {
  final String name;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final int current;
  final int goal;
  final String unit;

  const HabitModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.current,
    required this.goal,
    required this.unit,
  });

  double get progress => current / goal;
  bool get isCompleted => current >= goal;
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const _green = Color(0xFF1D9E75);
  static const _greenDark = Color(0xFF085041);
  static const _greenLight = Color(0xFFE1F5EE);
  static const _greenMid = Color(0xFF5DCAA5);

  final List<HabitModel> _habits = const [
    HabitModel(
      name: 'Water',
      icon: Icons.water_drop_outlined,
      color: Color(0xFF378ADD),
      bgColor: Color(0xFFE6F1FB),
      current: 6,
      goal: 8,
      unit: 'glasses',
    ),
    HabitModel(
      name: 'Exercise',
      icon: Icons.directions_run_rounded,
      color: Color(0xFF639922),
      bgColor: Color(0xFFEAF3DE),
      current: 30,
      goal: 30,
      unit: 'min',
    ),
    HabitModel(
      name: 'Reading',
      icon: Icons.menu_book_outlined,
      color: Color(0xFFBA7517),
      bgColor: Color(0xFFFAEEDA),
      current: 10,
      goal: 30,
      unit: 'min',
    ),
    HabitModel(
      name: 'Meditation',
      icon: Icons.self_improvement_outlined,
      color: Color(0xFF7F77DD),
      bgColor: Color(0xFFEEEDFE),
      current: 0,
      goal: 15,
      unit: 'min',
    ),
  ];

  // Mon–Sun completion ratios for the weekly bar chart
  final List<double> _weeklyData = [0.8, 0.5, 1.0, 0.4, 0.9, 1.0, 0.6];
  final List<String> _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final int _todayIndex = 6; // Sunday

  int get _completedCount => _habits.where((h) => h.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _greenLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel("Today's habits"),
                    const SizedBox(height: 10),
                    ..._habits.map(
                      (h) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildHabitCard(h),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSectionLabel('This week'),
                    const SizedBox(height: 10),
                    _buildWeeklyChart(),
                    const SizedBox(height: 20),
                    _buildAddButton(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final now = DateTime.now();
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final dateStr =
        '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';

    return Container(
      width: double.infinity,
      color: _green,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateStr,
                    style: const TextStyle(color: _greenMid, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Good morning, Jane',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRouter.profile),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: _greenDark,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'JD',
                      style: TextStyle(
                        color: _greenMid,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressSummary(),
        ],
      ),
    );
  }

  Widget _buildProgressSummary() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _greenDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: Stack(
              children: [
                SizedBox(
                  width: 52,
                  height: 52,
                  child: CircularProgressIndicator(
                    value: _completedCount / _habits.length,
                    strokeWidth: 5,
                    backgroundColor: const Color(0xFF0F6E56),
                    valueColor: const AlwaysStoppedAnimation<Color>(_greenMid),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Center(
                  child: Text(
                    '$_completedCount/${_habits.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_completedCount of ${_habits.length} done',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_habits.length - _completedCount} habits remaining',
                style: const TextStyle(color: _greenMid, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(HabitModel habit) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRouter.habitDetail),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: habit.isCompleted ? _greenMid : const Color(0xFFD3D1C7),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: habit.bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(habit.icon, color: habit.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF085041),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            value: habit.progress.clamp(0.0, 1.0),
                            minHeight: 5,
                            backgroundColor: _greenLight,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              habit.color,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${habit.current}/${habit.goal} ${habit.unit}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF888780),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: habit.isCompleted
                    ? habit.bgColor
                    : const Color(0xFFF1EFE8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                habit.isCompleted ? Icons.check_rounded : Icons.circle_outlined,
                size: 14,
                color: habit.isCompleted
                    ? habit.color
                    : const Color(0xFFB4B2A9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _greenMid, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(_weekDays.length, (i) {
          final isToday = i == _todayIndex;
          final barHeight = (_weeklyData[i] * 44).clamp(6.0, 44.0);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: barHeight,
                decoration: BoxDecoration(
                  color: isToday ? _greenMid : _green,
                  borderRadius: BorderRadius.circular(99),
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

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF085041),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRouter.addHabit),
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: _green,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}
