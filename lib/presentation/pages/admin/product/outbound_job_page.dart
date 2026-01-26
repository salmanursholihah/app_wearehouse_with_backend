import 'package:flutter/material.dart';

class JobFormPage extends StatefulWidget {
  final String productName;

  const JobFormPage({super.key, required this.productName});

  @override
  State<JobFormPage> createState() => _JobFormPageState();
}

class _JobFormPageState extends State<JobFormPage> {
  static const primaryColor = Color(0xFF2FA4A9);

  final formKey = GlobalKey<FormState>();

  final useForController = TextEditingController();
  final qtyController = TextEditingController();
  final descController = TextEditingController();

  String status = "Pending";
  String priority = "Normal";

  DateTime selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text("Konfirmasi Job"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Barang : ${widget.productName}"),
            Text("Untuk : ${useForController.text}"),
            Text("Qty : ${qtyController.text}"),
            Text("Priority : $priority"),
            Text("Status : $status"),
            Text("Tanggal : ${selectedDate.toString().substring(0, 10)}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Job Maintenance Berhasil Dibuat"),
                ),
              );

              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text("Job / Maintenance"),
        backgroundColor: primaryColor,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productCard(),
              const SizedBox(height: 16),

              _inputUseFor(),
              const SizedBox(height: 12),

              _inputQty(),
              const SizedBox(height: 12),

              _priorityPicker(),
              const SizedBox(height: 12),

              _statusPicker(),
              const SizedBox(height: 12),

              _datePicker(),
              const SizedBox(height: 12),

              _description(),
              const SizedBox(height: 24),

              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== WIDGET =====================

  Widget _productCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: primaryColor.withOpacity(0.15),
            child: const Icon(Icons.build, color: primaryColor),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Asset / Product",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  widget.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputUseFor() {
    return TextFormField(
      controller: useForController,

      validator: (v) =>
          v!.isEmpty ? "Tujuan penggunaan wajib diisi" : null,

      decoration: InputDecoration(
        labelText: "Digunakan Untuk",
        prefixIcon: const Icon(Icons.work),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _inputQty() {
    return TextFormField(
      controller: qtyController,
      keyboardType: TextInputType.number,

      validator: (v) {
        if (v == null || v.isEmpty) return "Jumlah wajib diisi";
        if (int.tryParse(v) == null) return "Harus angka";
        return null;
      },

      decoration: InputDecoration(
        labelText: "Jumlah",
        prefixIcon: const Icon(Icons.numbers),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _priorityPicker() {
    return DropdownButtonFormField<String>(
      value: priority,
      decoration: InputDecoration(
        labelText: "Priority",
        prefixIcon: const Icon(Icons.flag),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(value: "Low", child: Text("Low")),
        DropdownMenuItem(value: "Normal", child: Text("Normal")),
        DropdownMenuItem(value: "High", child: Text("High")),
        DropdownMenuItem(value: "Urgent", child: Text("Urgent")),
      ],
      onChanged: (v) => setState(() => priority = v!),
    );
  }

  Widget _statusPicker() {
    return DropdownButtonFormField<String>(
      value: status,
      decoration: InputDecoration(
        labelText: "Status",
        prefixIcon: const Icon(Icons.info),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(value: "Pending", child: Text("Pending")),
        DropdownMenuItem(value: "ACC", child: Text("ACC")),
        DropdownMenuItem(value: "Reject", child: Text("Reject")),
        DropdownMenuItem(value: "On Progress", child: Text("On Progress")),
      ],
      onChanged: (v) => setState(() => status = v!),
    );
  }

  Widget _datePicker() {
    return InkWell(
      onTap: _pickDate,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.date_range, color: primaryColor),
            const SizedBox(width: 10),
            Text(
              "Tanggal : ${selectedDate.toString().substring(0, 10)}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return TextFormField(
      controller: descController,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: "Deskripsi Pekerjaan",
        prefixIcon: const Icon(Icons.note),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,

      child: ElevatedButton.icon(
        icon: const Icon(Icons.save),

        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        onPressed: _submit,
        label: const Text("Buat Job"),
      ),
    );
  }
}
