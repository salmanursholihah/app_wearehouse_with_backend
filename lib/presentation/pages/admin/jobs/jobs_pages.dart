import 'package:flutter/material.dart';
import '../../shared/jobs/job_detail_page.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  String selectedFilter = 'All';
  String search = '';

  final List<Map<String, String>> jobs = [
    {
      'title': 'AC Unit Service',
      'location': 'Building A - Floor 2',
      'priority': 'High',
      'status': 'In Progress',
      'description': 'AC tidak dingin, perlu pengecekan freon dan filter.',
    },
    {
      'title': 'Generator Check',
      'location': 'Warehouse Area',
      'priority': 'Medium',
      'status': 'Pending',
      'description': 'Pengecekan rutin generator bulanan dan ganti oli.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = jobs.where((job) {
      final matchFilter =
          selectedFilter == 'All' || job['status'] == selectedFilter;

      final matchSearch =
          job['title']!.toLowerCase().contains(search.toLowerCase());

      return matchFilter && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text('Jobs & Maintenance'),
        backgroundColor: const Color(0xFF2FA4A9),
      ),

      body: Column(
        children: [
          _buildSearch(),
          _buildFilter(),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final job = filtered[i];

                return _JobCard(
                  title: job['title']!,
                  location: job['location']!,
                  priority: job['priority']!,
                  status: job['status']!,
                  description: job['description']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobDetailPage(
                          title: job['title']!,
                          location: job['location']!,
                          priority: job['priority']!,
                          status: job['status']!,
                          description: job['description']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (v) => setState(() => search = v),
        decoration: InputDecoration(
          hintText: 'Search job...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilter() {
    final filters = ['All', 'Pending', 'In Progress', 'Completed'];

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: filters.map((f) {
          final active = f == selectedFilter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(f),
              selected: active,
              onSelected: (_) => setState(() => selectedFilter = f),
              selectedColor: const Color(0xFF2FA4A9),
              labelStyle: TextStyle(
                color: active ? Colors.white : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _JobCard extends StatefulWidget {
  final String title;
  final String location;
  final String priority;
  final String status;
  final String description;

  final VoidCallback? onTap;

  const _JobCard({
    required this.title,
    required this.location,
    required this.priority,
    required this.status,
    required this.description,
    this.onTap,
  });

  @override
  State<_JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<_JobCard>
    with SingleTickerProviderStateMixin {

  double scale = 1;

  Color get statusColor {
    switch (widget.status) {
      case 'In Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.97),
      onTapUp: (_) => setState(() => scale = 1),
      onTapCancel: () => setState(() => scale = 1),

      onTap: widget.onTap,

      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),

        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: statusColor.withOpacity(0.2)),
          ),

          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.build, color: statusColor),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      widget.location,
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        _Badge(widget.priority, Colors.red),
                        const SizedBox(width: 6),
                        _Badge(widget.status, statusColor),
                      ],
                    )
                  ],
                ),
              ),

              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
