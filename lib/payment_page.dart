import 'package:flutter/material.dart';

enum PaymentMethod {
  CreditCard,
  DebitCard,
  PayPal,
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod? _selectedPaymentMethod;
  TextEditingController _amountController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.blue[900], // Dark blue app bar color
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Payment Method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              buildPaymentMethodCard(
                icon: Icons.credit_card,
                title: 'Credit Card',
                subtitle: 'Pay with your credit card',
                isSelected: _selectedPaymentMethod == PaymentMethod.CreditCard,
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = PaymentMethod.CreditCard;
                  });
                },
              ),
              SizedBox(height: 10),
              buildPaymentMethodCard(
                icon: Icons.payment,
                title: 'Debit Card',
                subtitle: 'Pay with your debit card',
                isSelected: _selectedPaymentMethod == PaymentMethod.DebitCard,
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = PaymentMethod.DebitCard;
                  });
                },
              ),
              SizedBox(height: 10),
              buildPaymentMethodCard(
                icon: Icons.account_balance_wallet,
                title: 'PayPal',
                subtitle: 'Pay with PayPal',
                isSelected: _selectedPaymentMethod == PaymentMethod.PayPal,
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = PaymentMethod.PayPal;
                  });
                },
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Amount',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter the amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_selectedPaymentMethod != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Payment Details',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        if (_selectedPaymentMethod == PaymentMethod.CreditCard ||
                            _selectedPaymentMethod == PaymentMethod.DebitCard)
                          buildCardPaymentForm(),
                        if (_selectedPaymentMethod == PaymentMethod.PayPal)
                          buildPayPalPaymentForm(),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _processPayment();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900], // Button background color
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'Proceed to Pay',
                            style: TextStyle(fontSize: 18, color: Colors.white), // Text color changed to white
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentMethodCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Colors.blue[50] : Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isSelected ? Colors.blue[900] : Colors.grey),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.blue[900] : Colors.black),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: isSelected ? Colors.blue[900] : Colors.grey)),
        trailing: isSelected ? Icon(Icons.check_circle, color: Colors.green) : null,
      ),
    );
  }

  Widget buildCardPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Card Number',
            hintText: 'XXXX-XXXX-XXXX-XXXX',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          maxLength: 19,
          onChanged: (value) {
            // Validate or format card number as needed
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'MM/YY',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                maxLength: 5,
                onChanged: (value) {
                  // Validate or format expiry date as needed
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: 'XXX',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 3,
                onChanged: (value) {
                  // Validate or format CVV as needed
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPayPalPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'PayPal Username',
            hintText: 'Enter your PayPal username',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            // Handle PayPal username input
          },
        ),
      ],
    );
  }

  void _processPayment() {
    // Replace with your payment processing logic
    double amount = double.parse(_amountController.text);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Confirmation'),
          content: Text('Your payment of \$${amount.toStringAsFixed(2)} via $_selectedPaymentMethod has been processed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentPage(),
  ));
}
