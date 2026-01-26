import 'package:flutter/material.dart';

class InventoryDetailPage extends StatefulWidget {
  final String name;

  const InventoryDetailPage({super.key, required this.name});

  @override
  State<InventoryDetailPage> createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  static const primaryColor = Color(0xFF2FA4A9);

  int stock = 25;

  // ================= UPDATE STOCK DIALOG =================
  void _showUpdateDialog() {
    final qtyController = TextEditingController();
    final noteController = TextEditingController();

    String action = 'add';
    String reason = 'Purchase';

    final reasons = [
      'Purchase',
      'Return',
      'Adjustment',
      'Damage',
      'Usage',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              title: const Text('Stock Transaction'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// INPUT QTY
                    TextField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'Enter total items',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ACTION TYPE
                    const Text("Action Type"),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: const Text('Add Stock'),
                            selected: action == 'add',
                            onSelected: (_) =>
                                setDialog(() => action = 'add'),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: ChoiceChip(
                            label: const Text('Reduce Stock'),
                            selected: action == 'reduce',
                            selectedColor: Colors.red.shade100,
                            onSelected: (_) =>
                                setDialog(() => action = 'reduce'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// REASON
                    const Text("Reason"),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: reason,
                      items: reasons.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (v) =>
                          setDialog(() => reason = v ?? reason),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// NOTE
                    TextField(
                      controller: noteController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Note (optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// PREVIEW RESULT
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Preview Result",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 6),

                          Text("Current Stock : $stock"),

                          Text(
                            "After Update : ${_previewStock(
                              qtyController.text,
                              action,
                            )}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),

                  onPressed: () {
                    final qty =
                        int.tryParse(qtyController.text) ?? 0;

                    /// VALIDASI
                    if (qty <= 0) {
                      _toast("Quantity must be greater than 0");
                      return;
                    }

                    if (action == 'reduce' && qty > stock) {
                      _toast("Stock not enough!");
                      return;
                    }

                    setState(() {
                      if (action == 'add') {
                        stock += qty;
                      } else {
                        stock -= qty;
                      }
                    });

                    Navigator.pop(context);

                    /// SIMULASI LOG (nanti untuk API)
                    debugPrint("""
TRANSACTION LOG
---------------
Item   : ${widget.name}
Action : $action
Qty    : $qty
Reason : $reason
Note   : ${noteController.text}
Stock  : $stock
""");

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Stock updated successfully'),
                      ),
                    );
                  },

                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ================= HELPER =================

  int _previewStock(String text, String action) {
    final qty = int.tryParse(text) ?? 0;

    if (action == 'add') {
      return stock + qty;
    } else {
      return (stock - qty).clamp(0, 9999);
    }
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg),
      ),
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text('Inventory Detail'),
        backgroundColor: primaryColor,
      ),

      body: Column(
        children: [
          _header(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoCard(),
                  const SizedBox(height: 24),
                  _actionButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Item Detail', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text(
            'Inventory Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          _rowItem(
            icon: Icons.inventory_2_outlined,
            title: 'Item Name',
            value: widget.name,
          ),

          const Divider(height: 32),

          _rowItem(
            icon: Icons.storage_outlined,
            title: 'Stock Available',
            value: '$stock Units',
            valueColor: stock < 5 ? Colors.red : Colors.black,
          ),

          const Divider(height: 32),

          _rowItem(
            icon: Icons.category_outlined,
            title: 'Category',
            value: 'Warehouse Goods',
          ),
        ],
      ),
    );
  }

  Widget _rowItem({
    required IconData icon,
    required String title,
    required String value,
    Color valueColor = Colors.black,
  }) {
    return Row(
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryColor),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  )),

              const SizedBox(height: 4),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  value,
                  key: ValueKey(value),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,

      child: ElevatedButton.icon(
        onPressed: _showUpdateDialog,

        icon: const Icon(Icons.edit),

        label: const Text(
          'Update Stock',
          style: TextStyle(fontSize: 16),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
