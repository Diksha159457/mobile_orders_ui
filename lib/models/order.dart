// Defines the execution side: whether the user is buying or selling an asset.
enum OrderSide { buy, sell }
// Defines the type of product (e.g., Cash and Carry, Normal, Intraday).
enum ProductType { cnc, nrml, intraday }

// The blueprint (data model) representing a single trade order.
class TradeOrder {
  final String ticker; // The symbol of the stock/asset (e.g., RELIANCE).
  final OrderSide side; // The action side (Buy or Sell).
  final ProductType product; // The holding type (CNC, NRML, INTRADAY).
  final int qtyExecuted; // Number of shares that have been executed.
  final int qtyTotal; // Total number of shares requested in the order.
  final double price; // The target or executed price of the order.
  final String clientId; // The ID of the client placing the order.
  final DateTime time; // The exact timestamp when the order was placed.

  // Constructor to initialize a TradeOrder object with all required fields.
  TradeOrder({
    required this.ticker,
    required this.side,
    required this.product,
    required this.qtyExecuted,
    required this.qtyTotal,
    required this.price,
    required this.clientId,
    required this.time,
  });

  // A helper getter that formats the Datetime object into a readable "HH:MM:SS" string.
  String get timeFormatted {
    // Pads single digits with a leading '0' to maintain a uniform format.
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  // A helper getter that converts the ProductType enum into a displayable string.
  String get productTypeString {
    switch (product) {
      case ProductType.cnc:
        return 'CNC'; // Cash and Carry
      case ProductType.nrml:
        return 'NRML'; // Normal (often for Futures and Options)
      case ProductType.intraday:
        return 'INTRADAY'; // Same day square-off
    }
  }

  // A helper getter that converts the OrderSide enum into a displayable string.
  String get sideString {
    switch (side) {
      case OrderSide.buy:
        return 'Buy'; // A purchase order
      case OrderSide.sell:
        return 'Sell'; // A selling order
    }
  }
}

// Hardcoded mock data closely resembling the test image provided by the user.
final List<TradeOrder> sampleOrders = [
  // First mock order simulating a Reliance purchase
  TradeOrder(
    ticker: 'RELIANCE',
    side: OrderSide.buy,
    product: ProductType.cnc,
    qtyExecuted: 50,
    qtyTotal: 100,
    price: 250.50,
    clientId: 'AAA001',
    time: DateTime.now().subtract(const Duration(minutes: 5, seconds: 12)), // Set artificially to 5 mins ago
  ),
  // Second mock order simulating an MRF purchase
  TradeOrder(
    ticker: 'MRF',
    side: OrderSide.buy,
    product: ProductType.nrml,
    qtyExecuted: 10,
    qtyTotal: 20,
    price: 2700.00,
    clientId: 'AAA003',
    time: DateTime.now().subtract(const Duration(minutes: 15, seconds: 40)), // Set to 15 mins ago
  ),
  // Third mock order simulating an Asian Paints purchase
  TradeOrder(
    ticker: 'ASIANPAINT',
    side: OrderSide.buy,
    product: ProductType.nrml,
    qtyExecuted: 10,
    qtyTotal: 30,
    price: 1500.60,
    clientId: 'AAA002',
    time: DateTime.now().subtract(const Duration(minutes: 25, seconds: 10)), // Set to 25 mins ago
  ),
  // Fourth mock order simulating an intraday short/sell on Tata Investment
  TradeOrder(
    ticker: 'TATAINVEST',
    side: OrderSide.sell,
    product: ProductType.intraday,
    qtyExecuted: 10,
    qtyTotal: 10,
    price: 2300.10,
    clientId: 'AAA002',
    time: DateTime.now().subtract(const Duration(hours: 1, minutes: 10)), // Set to 1 hr 10 mins ago
  ),
];
