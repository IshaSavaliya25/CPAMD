class ExpenseData {
  double amount;
  String category;
  String paymentType;
  String date;
  String timestamp;

  ExpenseData({
    required this.amount,
    required this.category,
    required this.paymentType,
    required this.date,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'paymentType': paymentType,
      'date': date, 
      'timestamp': timestamp, 
    };
  }

  factory ExpenseData.fromMap(Map<String, dynamic> map) {
    return ExpenseData(
      amount: map['amount'],
      category: map['category'],
      paymentType: map['paymentType'],
      date: map['date'],
      timestamp: map['timestamp'],
    );
  }
}
