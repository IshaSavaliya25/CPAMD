import 'package:flutter/material.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  TextEditingController totalWeight = TextEditingController();
  TextEditingController carat = TextEditingController();
  TextEditingController gprice = TextEditingController();
  TextEditingController cprice = TextEditingController();
  TextEditingController lcharge = TextEditingController();

  double? inPrice;
  double? lbcost;
  double? makingCharge;
  double? gtotal;

  void calculate() {
    double twt = double.tryParse(totalWeight.text) ?? 0;
    double ct = double.tryParse(carat.text) ?? 24;
    double gp = double.tryParse(gprice.text) ?? 0;
    double cp = double.tryParse(cprice.text) ?? 0;
    double lbcp = double.tryParse(lcharge.text) ?? 0;

    // Gold & copper weight calculation
    double goldwt = (ct / 24) * twt;
    double cpwt = twt - goldwt;

    // Price for gold & copper (per 10g → per gram)
    double goldprice = goldwt * (gp / 10);
    double copperprice = cpwt * (cp / 10);

    // Material cost
    double totalMaterial = goldprice + copperprice;

    // Labour charge (either % or ₹500, whichever is higher)
    double labourCost = totalMaterial * lbcp * 0.01;
    if (labourCost < 500) {
      labourCost = 500;
    }

    // Making charge = 1% of material cost
    double mkCharge = totalMaterial * 0.01;

    // Grand total
    double total = totalMaterial + labourCost + mkCharge;

    setState(() {
      inPrice = totalMaterial;
      lbcost = labourCost;
      makingCharge = mkCharge;
      gtotal = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💎 Ornament Price Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTextField(totalWeight, "Total weight (g)"),
            buildTextField(carat, "Carat (e.g., 22)"),
            buildTextField(gprice, "Gold price per 10g (₹)"),
            buildTextField(cprice, "Copper price per 10g (₹)"),
            buildTextField(lcharge, "Labour charge (%)"),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              child: const Text('Calculate 💰', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            if (gtotal != null) ...[
              buildResult('Material Price', inPrice!),
              buildResult('Labour Charge', lbcost!),
              buildResult('Making Charge (1%)', makingCharge!),
              const Divider(),
              buildResult('💎 Grand Total', gtotal!, isTotal: true),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildResult(String title, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            "₹ ${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
