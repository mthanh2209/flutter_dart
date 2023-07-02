import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sell_book/component/CustomButton.dart';
import 'package:sell_book/component/Custom_textfile.dart';
import 'package:sell_book/pages/DetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool _isVIP = false;
  double _totalAmount = 0.0;
  List<Invoice> _invoices = [];

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  void _calculateTotalAmount() {
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    double discount = _isVIP ? 0.1 : 0.0; // 10% discount if VIP customer
    double total = quantity * price;
    double discountedTotal = total - (total * discount);

    setState(() {
      _totalAmount = discountedTotal;
    });
  }

  void _showDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage()),
    );
  }

  void _saveInformation() async {
    String customerName = _customerNameController.text;
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    if (customerName.isEmpty || quantity == 0 || price == 0.0) {
      // Hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: const Text('Vui lòng điền đầy đủ thông tin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
      return; // Dừng lại nếu có lỗi
    }

    bool isPaid = false;
    bool isVip = false;
    // Tiếp tục lưu thông tin hoá đơn
    Invoice newInvoice = Invoice(
      customerName: customerName,
      quantity: quantity,
      price: price,
      totalAmount: _totalAmount,
      isPaid: isPaid,
      isVip: _isVIP,
    );

    setState(() {
      _invoices.add(newInvoice);
    });

    // Reset form fields
    _customerNameController.clear();
    _quantityController.clear();
    _priceController.clear();
    _isVIP = false;
    _totalAmount = 0.0;

    //Luư thông tin hoá đơn vào Shared Preferences

    await _saveInvoices();
  }

  void _deleteInvoice(int index) async {
    setState(() {
      _invoices.removeAt(index);
    });

    // Lưu thông tin hoá đơn đã xoá vào Shared Preferences
    await _saveInvoices();
  }

  Future<void> _saveInvoices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> invoiceStrings =
        _invoices.map((invoice) => invoice.toJson()).toList();
    await prefs.setStringList('invoices', invoiceStrings);
  }

  Future<void> _loadInvoices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? invoiceStrings = prefs.getStringList('invoices');
    if (invoiceStrings != null) {
      List<Invoice> invoices =
          invoiceStrings.map((string) => Invoice.fromJson(string)).toList();
      setState(() {
        _invoices = invoices;
      });
    }
  }

  Future<void> _showConfirmationDialog(
      String title, String message, Function() onConfirm) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _Dialog(
      String title, String message, Function() onConfirm) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }

  void _markAsUnpaid(int index) {
    _Dialog('Trạng thái hoá đơn', 'Hoá đơn chưa thanh toán!', () {
      setState(() {
        _invoices[index].isPaid = false;
        _saveInvoices();
      });
    });
  }

  void _markAsPaid(int index) {
    _showConfirmationDialog('Xác nhận', 'Đánh dấu hoá đơn đã thanh toán?', () {
      setState(() {
        _invoices[index].isPaid = true;
        _saveInvoices();
      });
    });
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bghp.png"),
                fit: BoxFit.fitWidth)),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Positioned.fill(
              child: Column(children: [
                Center(
                    child: Text(
                  'Thông tin hoá đơn.',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 26.0,
                    color: Color.fromARGB(255, 243, 8, 8),
                  ),
                ))
              ]),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextField(
                controller: _customerNameController,
                hintText: "Tên khách hàng",
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 10.0),
                    child: CustomTextField(
                      controller: _quantityController,
                      hintText: "Số lượng sách",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 10.0),
                    child: CustomTextField(
                      controller: _priceController,
                      hintText: "Price / 1 đơn vị",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Checkbox(
                    value: _isVIP,
                    onChanged: (value) {
                      setState(() {
                        _isVIP = value ?? false;
                        _calculateTotalAmount(); // Recalculate total amount when VIP status changes
                      });
                    },
                  ),
                ),
                const Text(
                  'Khách hàng VIP',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      _calculateTotalAmount();
                    },
                    child: const Text('Thành tiền')),
                const SizedBox(width: 16.0),
                Container(
                  padding:
                      const EdgeInsets.all(8), // Khoảng cách giữa khung và nội dung
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(
                          255, 212, 20, 20), // Màu viền của khung
                      width: 1, // Độ dày của viền
                    ),
                    borderRadius: BorderRadius.circular(8), // Bo góc của khung
                  ),
                  child: Text(
                    '$_totalAmount',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Center(
                child: CustomButton(
              onPressed: () {
                _saveInformation(); // Lưu thông tin
              },
              text: 'Lưu thông tin',
            )),
            const SizedBox(height: 8.0),
            const Divider(
              color: Colors.red,
            ),
            const Center(
                child: Text(
              'Xác nhận hoá đơn:',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                  decoration: TextDecoration.underline),
            )),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _invoices.length,
                itemBuilder: (context, index) {
                  Invoice invoice = _invoices[index];
                  return ListTile(
                    title: ListTile(
                      title: RichText(
                        text: TextSpan(
                            text: invoice.customerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              if (invoice.isVip)
                                const TextSpan(
                                    text: '  (VIP) ',
                                    style: TextStyle(color: Colors.red))
                            ]),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số lượng sách: ${invoice.quantity}',
                            style: const TextStyle(
                                fontSize: 13.0,
                                color: Color.fromARGB(255, 148, 139, 13)),
                          ),
                          Text(
                            'Đơn giá: ${invoice.price}',
                            style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Thành tiền: ${invoice.totalAmount}',
                              style: const TextStyle(
                                  fontSize: 13.0,
                                  color: Color.fromARGB(255, 26, 16, 1),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!invoice.isPaid) ...[
                          Checkbox(
                            value: invoice.isPaid,
                            onChanged: (value) {
                              _markAsPaid(index);
                            },
                          ),
                          Checkbox(
                            value: !invoice.isPaid,
                            onChanged: (value) {
                              _markAsUnpaid(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _showConfirmationDialog(
                                  'Xác nhận', 'Xóa hoá đơn?', () {
                                _deleteInvoice(index);
                              });
                            },
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Invoice {
  final String customerName;
  final int quantity;
  final double price;
  final double totalAmount;
  bool isPaid;
  bool isVip;

  Invoice({
    required this.customerName,
    required this.quantity,
    required this.price,
    required this.totalAmount,
    this.isPaid = false,
    this.isVip = false,
  });

  String toJson() {
    return '{"customerName":"$customerName","quantity":$quantity,"price":$price,"totalAmount":$totalAmount,"isPaid":$isPaid,"isVip":$isVip}';
  }

  factory Invoice.fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return Invoice(
      customerName: data['customerName'],
      quantity: data['quantity'],
      price: data['price'],
      totalAmount: data['totalAmount'],
      isPaid: data['isPaid'],
      isVip: data['isVip'],
    );
  }
}
