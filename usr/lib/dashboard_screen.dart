import 'package:flutter/material.dart';
import 'package:couldai_user_app/widgets/metric_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _dateRange = 'This Month';
  String _compareTo = 'Previous Period';
  String _revenuePeriod = 'MTD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Dashboard'),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterBar(),
            const SizedBox(height: 24),
            _buildMetricsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        _buildFilterDropdown('DATE RANGE', _dateRange, ['Today', 'This Week', 'This Month', 'This Quarter', 'Custom'], (value) {
          setState(() {
            _dateRange = value!;
          });
        }),
        _buildFilterDropdown('COMPARE TO', _compareTo, ['Previous Period', 'Last Year same period'], (value) {
          setState(() {
            _compareTo = value!;
          });
        }),
      ],
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              dropdownColor: const Color(0xFF1E293B),
              style: const TextStyle(color: Colors.white),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid() {
    // Mock data for the dashboard
    final metrics = [
      {'title': 'Total Leads', 'value': '1,234', 'change': '+15.2%', 'isUp': true},
      {'title': 'Opportunities in Pipeline', 'value': '\$2.5M', 'change': 'Value', 'isUp': null},
      {'title': 'Conversion Rate (Leads → Deals)', 'value': '4.8%', 'change': '-0.5%', 'isUp': false},
      {'title': 'Average Deal Size', 'value': '\$15,430', 'change': 'vs \$14,210 last period', 'isUp': true},
      {'title': 'Top Performing Sales Rep', 'value': 'John Smith', 'change': '52 Deals', 'isUp': null},
      {'title': 'Pending Activities / Tasks', 'value': '42', 'change': '7 Overdue', 'isUp': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRevenueCard(),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = (constraints.maxWidth < 600) ? 1 : (constraints.maxWidth < 1200 ? 2 : 3);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: (constraints.maxWidth < 600) ? 3 : 2.2,
              ),
              itemCount: metrics.length,
              itemBuilder: (context, index) {
                final metric = metrics[index];
                return MetricCard(
                  title: metric['title'] as String,
                  value: metric['value'] as String,
                  change: metric['change'] as String,
                  isUp: metric['isUp'] as bool?,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildRevenueCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Closed Deals / Revenue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildRevenueToggle(),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '\$452,789',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.greenAccent),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 16),
                const SizedBox(width: 4),
                Text(
                  '+8.5% vs last period',
                  style: TextStyle(color: Colors.greenAccent.withOpacity(0.8)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueToggle() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ToggleButtons(
        isSelected: [_revenuePeriod == 'MTD', _revenuePeriod == 'QTD', _revenuePeriod == 'YTD'],
        onPressed: (index) {
          setState(() {
            if (index == 0) _revenuePeriod = 'MTD';
            if (index == 1) _revenuePeriod = 'QTD';
            if (index == 2) _revenuePeriod = 'YTD';
          });
        },
        borderRadius: BorderRadius.circular(8),
        selectedColor: Colors.white,
        color: Colors.white70,
        fillColor: Colors.blue.shade600,
        splashColor: Colors.blue.withOpacity(0.2),
        highlightColor: Colors.blue.withOpacity(0.2),
        borderWidth: 0,
        selectedBorderColor: Colors.transparent,
        children: const [
          Padding(padding: EdgeInsets.symmetric(horizontal: 12.0), child: Text('MTD')),
          Padding(padding: EdgeInsets.symmetric(horizontal: 12.0), child: Text('QTD')),
          Padding(padding: EdgeInsets.symmetric(horizontal: 12.0), child: Text('YTD')),
        ],
      ),
    );
  }
}
