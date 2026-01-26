import 'package:flutter/material.dart';

class DistributeFormPage extends StatefulWidget {
  final String productName;

  const DistributeFormPage({
    super.key,
    required this.productName,
  });

  @override
  State<DistributeFormPage> createState() => _DistributeFormPageState();
}

class _DistributeFormPageState extends State<DistributeFormPage> {
  static const primaryColor = Color(0xFF2FA4A9);

  final formKey = GlobalKey<FormState>();

  final qtyController = TextEditingController();
  final noteController = TextEditingController();
  final invoiceController = TextEditingController();

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

        title: const Text("Konfirmasi"),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Barang : ${widget.productName}"),
            Text("Qty : ${qtyController.text}"),
            Text("No Faktur : ${invoiceController.text}"),
            Text("Tanggal : ${selectedDate.toString().substring(0, 10)}"),
            const SizedBox(height: 8),
            Text("Note : ${noteController.text}"),
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
                  content: Text("Outbound Distributor Berhasil Disimpan"),
                ),
              );

              Navigator.pop(context);
            },

            child: const Text("Ya, Simpan"),
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
        title: const Text("Outbound Distributor"),
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

              _inputQty(),

              const SizedBox(height: 12),

              _inputInvoice(),

              const SizedBox(height: 12),

              _datePicker(),

              const SizedBox(height: 12),

              _inputNote(),

              const SizedBox(height: 20),

              _uploadInvoiceMock(),

              const SizedBox(height: 24),

              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

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
            child: const Icon(Icons.inventory,
                color: primaryColor),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Product",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                Text(
                  widget.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputQty() {
    return TextFormField(
      controller: qtyController,
      keyboardType: TextInputType.number,

      validator: (v) {
        if (v == null || v.isEmpty) {
          return "Qty wajib diisi";
        }

        if (int.tryParse(v) == null) {
          return "Harus angka";
        }

        return null;
      },

      decoration: InputDecoration(
        labelText: "Quantity",
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

  Widget _inputInvoice() {
    return TextFormField(
      controller: invoiceController,

      validator: (v) =>
          v!.isEmpty ? "No faktur wajib diisi" : null,

      decoration: InputDecoration(
        labelText: "No Faktur",
        prefixIcon: const Icon(Icons.receipt),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
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
            const Icon(Icons.date_range,
                color: primaryColor),

            const SizedBox(width: 10),

            Text(
              "Tanggal : ${selectedDate.toString().substring(0, 10)}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputNote() {
    return TextFormField(
      controller: noteController,
      maxLines: 2,

      decoration: InputDecoration(
        labelText: "Keterangan",
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

  Widget _uploadInvoiceMock() {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [
          const Icon(Icons.upload_file,
              color: primaryColor),

          const SizedBox(width: 10),

          const Text("Upload Foto Faktur (opsional)"),

          const Spacer(),

          TextButton(
            onPressed: () {}, // nanti bisa pakai image picker
            child: const Text("Pilih File"),
          ),
        ],
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

        label: const Text("Submit Outbound"),
      ),
    );
  }
}
