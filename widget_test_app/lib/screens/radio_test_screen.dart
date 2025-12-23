import 'package:flutter/material.dart';
import 'package:widget_test_app/models/customers.dart';
import 'package:widget_test_app/models/item.dart';
import 'package:widget_test_app/reports/generate_pdf.dart';

class RadioTestScreen extends StatefulWidget {
  const RadioTestScreen({super.key});

  @override
  State<RadioTestScreen> createState() => _RadioTestScreenState();
}

class _RadioTestScreenState extends State<RadioTestScreen> {
  String selVal = "GST";
  TextEditingController txtCustName = TextEditingController();
  TextEditingController txtCustMono = TextEditingController();
  TextEditingController txtProd = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  TextEditingController txtRate = TextEditingController();
  TextEditingController txtAmnt = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtGstPer = TextEditingController();
  List<Item> cartItems = [];
  Customers customer = Customers(name: '', mono: '');
  double cgst = 0;
  double sgst = 0;
  double gtotal = 0;
  _calculateAmount(v) {
    if (txtQty.text.isNotEmpty && txtRate.text.isNotEmpty) {
      double qty = double.parse(txtQty.text);
      double rate = double.parse(txtRate.text);
      txtAmnt.text = (qty * rate).toStringAsFixed(2);
    }
  }

  _calAmt(double qty, double rate, double gstP) {
    return (qty * rate) + ((qty * rate) * 0.01 * gstP);
  }

  _calTotal() {
    gtotal = 0;
    cgst = 0;
    sgst = 0;
    for (Item i in cartItems) {
      var gstAmnt = i.qty * i.rate * 0.01 * i.gstPer;
      gtotal += (i.qty * i.rate) + gstAmnt;
      cgst += gstAmnt / 2;
      sgst += gstAmnt / 2;
    }
    setState(() {});
  }

  bool isCustEdit = false;
  bool isAdd = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Row(
              children: [
                Radio(
                  value: "GST",
                  groupValue: selVal,
                  onChanged: (v) {
                    selVal = v!;
                    setState(() {});
                  },
                ),
                Text('GST'),
              ],
            ),
            Expanded(
              child: RadioListTile(
                title: Text("Without GST"),
                value: "WGST",
                groupValue: selVal,
                onChanged: (v) {
                  selVal = v!;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              GeneratePdf.createPdf(customer);
              setState(() {});
            },
            icon: Icon(isAdd ? Icons.close : Icons.picture_as_pdf),
          ),
          IconButton(
            onPressed: () {
              isAdd = !isAdd;
              setState(() {});
            },
            icon: Icon(isAdd ? Icons.close : Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              isCustEdit
                  ? Column(
                    children: [
                      TextFormField(
                        controller: txtCustName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Customer Name",
                          labelText: "Customer Name",
                        ),
                      ),

                      SizedBox(height: 8),
                      TextFormField(
                        controller: txtCustMono,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Customer Mobile",
                          labelText: "Customer Mobile",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (txtCustName.text.isNotEmpty && txtCustMono.text.isNotEmpty) {
                            customer.name = txtCustName.text;
                            customer.mono = txtCustMono.text;
                            isCustEdit = false;
                            setState(() {});
                          }
                        },
                        child: Text('Save'),
                      ),
                    ],
                  )
                  : InkWell(
                    onTap: () {
                      isCustEdit = true;
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      color: const Color.fromARGB(255, 119, 194, 226),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(customer.name),
                          SizedBox(height: 8),
                          Text(customer.mono),
                        ],
                      ),
                    ),
                  ),
              if (isAdd)
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: txtProd,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Enter product Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Product",
                          labelText: "Enter Product",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: txtQty,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Enter Qty";
                          }
                          return null;
                        },
                        onChanged: _calculateAmount,
                        decoration: InputDecoration(
                          hintText: "Enter Qty",
                          labelText: "Enter Qty",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: txtRate,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Enter rate";
                          }
                          return null;
                        },
                        onChanged: _calculateAmount,
                        decoration: InputDecoration(
                          hintText: "Enter rate",
                          labelText: "Enter rate",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: txtAmnt,
                        decoration: InputDecoration(
                          hintText: "Enter amount",
                          labelText: "Enter amount",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      if (selVal == 'GST')
                        TextFormField(
                          controller: txtGstPer,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Enter GST%";
                            }
                            try {
                              double d = double.parse(v);
                              if (d > 100 || d < 0) {
                                return "Enter GST% between 0-100";
                              }
                            } catch (e) {
                              return "Enter valid number between 0-100";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter GST%",
                            labelText: "Enter GST%",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // calculate logic
                            double amnt = double.parse(txtAmnt.text);
                            if (selVal == "GST") {
                              double gstP = double.parse(txtGstPer.text);
                              cgst = amnt * 0.01 * gstP * 0.5;
                              sgst = amnt * 0.01 * gstP * 0.5;
                              gtotal = amnt + cgst + sgst;
                            } else {
                              gtotal = amnt;
                            }
                            cartItems.add(
                              Item(
                                prodName: txtProd.text,
                                qty: double.parse(txtQty.text),
                                rate: double.parse(txtRate.text),
                                gstPer: double.parse(txtGstPer.text),
                              ),
                            );
                            _calTotal();
                            setState(() {});
                          }
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder:
                      (context, index) => ListTile(
                        title: Text('${cartItems[index].prodName}'),
                        subtitle: Text(
                          '${cartItems[index].rate} * ${cartItems[index].qty} (${cartItems[index].gstPer})',
                        ),
                        trailing: Text(
                          _calAmt(
                            cartItems[index].qty,
                            cartItems[index].rate,
                            cartItems[index].gstPer,
                          ).toStringAsFixed(2),
                        ),
                      ),
                ),
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightGreenAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('CGST: ${cgst.toStringAsFixed(2)}'),
                    Text('SGST: ${sgst.toStringAsFixed(2)}'),
                    Text('IGST: ${(sgst + cgst).toStringAsFixed(2)}'),
                    Text('Grand Total: ${gtotal.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
