import 'package:flutter/material.dart';
import '../../domain/routes/router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _green = Color(0xFF1D9E75);
  static const _greenDark = Color(0xFF085041);
  static const _greenLight = Color(0xFFE1F5EE);
  static const _greenMid = Color(0xFF5DCAA5);

  bool _notificationsEnabled = true;
  bool _dailyReminderEnabled = true;
  String _selectedReminderTime = '08:00 AM';
  String _selectedTheme = 'System';

  // Mock user data
  final String _userName = 'Jane Doe';
  final String _userEmail = 'jane@email.com';
  final int _totalHabits = 4;
  final int _longestStreak = 12;
  final int _completedToday = 4;

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
                    const SizedBox(height: 24),
                    _buildSectionLabel('Notifications'),
                    const SizedBox(height: 10),
                    _buildNotificationsCard(),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Preferences'),
                    const SizedBox(height: 10),
                    _buildPreferencesCard(),
                    const SizedBox(height: 20),
                    _buildSectionLabel('Account'),
                    const SizedBox(height: 10),
                    _buildAccountCard(context),
                    const SizedBox(height: 20),
                    _buildLogoutButton(context),
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
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 28),
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
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _greenDark,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'JD',
                style: TextStyle(
                  color: _greenMid,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _userEmail,
            style: const TextStyle(color: _greenMid, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard('Habits', '$_totalHabits active', Icons.spa_outlined),
        const SizedBox(width: 10),
        _buildStatCard('Best streak', '$_longestStreak days', Icons.local_fire_department_outlined),
        const SizedBox(width: 10),
        _buildStatCard('Today', '$_completedToday done', Icons.check_circle_outline_rounded),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
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
            Icon(icon, color: _green, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF085041),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Color(0xFF888780)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD3D1C7), width: 0.5),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            icon: Icons.notifications_outlined,
            label: 'Push notifications',
            subtitle: 'Get reminders for your habits',
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            showDivider: true,
          ),
          _buildSwitchTile(
            icon: Icons.alarm_outlined,
            label: 'Daily reminder',
            subtitle: 'Morning summary of your habits',
            value: _dailyReminderEnabled,
            onChanged: (val) => setState(() => _dailyReminderEnabled = val),
            showDivider: _dailyReminderEnabled,
          ),
          if (_dailyReminderEnabled)
            _buildTapTile(
              icon: Icons.schedule_outlined,
              label: 'Reminder time',
              trailing: Text(
                _selectedReminderTime,
                style: const TextStyle(fontSize: 13, color: Color(0xFF1D9E75)),
              ),
              onTap: () => _showTimePicker(context),
              showDivider: false,
            ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD3D1C7), width: 0.5),
      ),
      child: Column(
        children: [
          _buildTapTile(
            icon: Icons.palette_outlined,
            label: 'Theme',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedTheme,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF888780)),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF888780)),
              ],
            ),
            onTap: () => _showThemePicker(context),
            showDivider: true,
          ),
          _buildTapTile(
            icon: Icons.language_outlined,
            label: 'Language',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('English', style: TextStyle(fontSize: 13, color: Color(0xFF888780))),
                SizedBox(width: 4),
                Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF888780)),
              ],
            ),
            onTap: () {},
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD3D1C7), width: 0.5),
      ),
      child: Column(
        children: [
          _buildTapTile(
            icon: Icons.person_outline_rounded,
            label: 'Edit profile',
            trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF888780)),
            onTap: () {},
            showDivider: true,
          ),
          _buildTapTile(
            icon: Icons.lock_outline_rounded,
            label: 'Change password',
            trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF888780)),
            onTap: () {},
            showDivider: true,
          ),
          _buildTapTile(
            icon: Icons.help_outline_rounded,
            label: 'Help & support',
            trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF888780)),
            onTap: () {},
            showDivider: true,
          ),
          _buildTapTile(
            icon: Icons.privacy_tip_outlined,
            label: 'Privacy policy',
            trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF888780)),
            onTap: () {},
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: _green, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF085041),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF888780)),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: _green,
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 0.5, thickness: 0.5, indent: 16, endIndent: 16, color: Color(0xFFD3D1C7)),
      ],
    );
  }

  Widget _buildTapTile({
    required IconData icon,
    required String label,
    required Widget trailing,
    required VoidCallback onTap,
    required bool showDivider,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(icon, color: _green, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF085041),
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 0.5, thickness: 0.5, indent: 16, endIndent: 16, color: Color(0xFFD3D1C7)),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout_rounded, size: 18, color: Color(0xFFD85A30)),
        label: const Text(
          'Log out',
          style: TextStyle(fontSize: 15, color: Color(0xFFD85A30)),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Color(0xFFF5C4B3), width: 0.5),
          backgroundColor: const Color(0xFFFAECE7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
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

  void _showTimePicker(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: _green),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        final minute = picked.minute.toString().padLeft(2, '0');
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        _selectedReminderTime = '$hour:$minute $period';
      });
    }
  }

  void _showThemePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose theme',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF085041),
              ),
            ),
            const SizedBox(height: 16),
            ...['System', 'Light', 'Dark'].map((theme) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(theme),
                  trailing: _selectedTheme == theme
                      ? const Icon(Icons.check_rounded, color: _green)
                      : null,
                  onTap: () {
                    setState(() => _selectedTheme = theme);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Log out',
          style: TextStyle(color: Color(0xFF085041), fontWeight: FontWeight.w500),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: Color(0xFF888780)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF888780))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.home,
                (route) => false,
              );
            },
            child: const Text('Log out', style: TextStyle(color: Color(0xFFD85A30))),
          ),
        ],
      ),
    );
  }
}