import 'package:flutter/material.dart';

class AdjustStockPage extends StatefulWidget {
  final String productName;

  const AdjustStockPage({
    super.key,
    required this.productName,
  });

  @override
  State<AdjustStockPage> createState() => _AdjustStockPageState();
}

class _AdjustStockPageState extends State<AdjustStockPage> {
  static const primaryColor = Color(0xFF2FA4A9);

  final qtyController = TextEditingController();
  final noteController = TextEditingController();

  String mode = "add"; // add / reduce
  int currentStock = 25;

  int get previewStock {
    final qty = int.tryParse(qtyController.text) ?? 0;

    if (mode == "add") {
      return currentStock + qty;
    } else {
      return (currentStock - qty).clamp(0, 9999);
    }
  }

  void _save() {
    final qty = int.tryParse(qtyController.text) ?? 0;

    if (qty <= 0) {
      _snack("Masukkan jumlah yang valid");
      return;
    }

    setState(() {
      currentStock = previewStock;
    });

    _snack("Stock berhasil diperbarui");

    qtyController.clear();
    noteController.clear();
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text("Adjust Stock"),
        backgroundColor: primaryColor,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ===== INFO PRODUCT =====
            _productCard(),

            const SizedBox(height: 20),

            // ===== PILIH MODE =====
            _modeSelector(),

            const SizedBox(height: 16),

            // ===== INPUT QTY =====
            _qtyInput(),

            const SizedBox(height: 16),

            // ===== NOTE =====
            _noteInput(),

            const SizedBox(height: 20),

            // ===== PREVIEW =====
            _previewCard(),

            const SizedBox(height: 24),

            // ===== BUTTON SAVE =====
            _saveButton(),
          ],
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.storage,
                  color: primaryColor),

              const SizedBox(width: 6),

              Text("Current Stock : $currentStock"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _modeSelector() {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text("Tambah Stock"),
            selected: mode == "add",
            selectedColor: primaryColor.withOpacity(0.2),
            onSelected: (_) {
              setState(() => mode = "add");
            },
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: ChoiceChip(
            label: const Text("Kurangi Stock"),
            selected: mode == "reduce",
            selectedColor: Colors.red.withOpacity(0.2),
            onSelected: (_) {
              setState(() => mode = "reduce");
            },
          ),
        ),
      ],
    );
  }

  Widget _qtyInput() {
    return TextField(
      controller: qtyController,
      keyboardType: TextInputType.number,

      onChanged: (_) => setState(() {}),

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

  Widget _noteInput() {
    return TextField(
      controller: noteController,
      maxLines: 2,

      decoration: InputDecoration(
        labelText: "Keterangan (opsional)",
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

  Widget _previewCard() {
    final isReduce = mode == "reduce";

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Preview Stock",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text("Setelah diupdate"),

              AnimatedSwitcher(
                duration:
                    const Duration(milliseconds: 300),
                child: Text(
                  "$previewStock pcs",
                  key: ValueKey(previewStock),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isReduce
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
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

        onPressed: _save,

        label: Text(
          mode == "add"
              ? "Tambah Stock"
              : "Kurangi Stock",
        ),
      ),
    );
  }
}
