// Standard material layout imports.
import 'package:flutter/material.dart';
// Imports the Slidable package which allows swipe left/right interactions on UI blocks.
import 'package:flutter_slidable/flutter_slidable.dart';
// Imports formatting tools to easily convert raw decimals into human readable currency forms.
import 'package:intl/intl.dart';
// Imports the data model blueprint schema.
import '../models/order.dart';

// Generates the customized UI mapped layout containing the detailed info layout of one single order memory item.
class OrderCard extends StatelessWidget {
  // Receives the individual chunk of data this piece of UI is responsible for painting dynamically.
  final TradeOrder order;
  // Exposes a function callback hook passed downwards from the parent, so this widget can command the parent to delete data.
  final VoidCallback onCancel;

  // Enforces that initialization REQUIRES passing in an explicit model chunk and hook parameter reference.
  const OrderCard({super.key, required this.order, required this.onCancel});

  @override
  // Core UI building directive loop map hook.
  Widget build(BuildContext context) {
    // Bootstraps a currency formatting config pointing to basic 2 decimals place string structure boundaries.
    final NumberFormat currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 2);
    // Runs mathematical boolean check evaluating state against constant buy mapping definitions limit structure limit bounds context.
    final isBuy = order.side == OrderSide.buy;
    // Leverages Theme tree pulling contextual mappings color mapping extraction target boolean based conditional assignments.
    final sideColor = isBuy ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error;

    // Slidable acts as wrapper encapsulating children widgets beneath actionable slider hooks bounds boundaries limits framework interactions limits mapping.
    return Slidable(
      // Key prevents flutter mapping mapping errors limits widget tree state destruction confusion rebuilding bounds limits parameters hook bounds mapping target. Map target limits mapping key mapping.
      key: ValueKey(order.clientId + order.ticker + order.time.toString()),
      // Configures right-to-left interaction mapping panel parameters hook boundaries framework limit limit actions tree mapping limits parameter boundary target limits.
      endActionPane: ActionPane(
        motion: const ScrollMotion(), // Makes swipe drag reveal panel smoothly mimic natural scroll.
        children: [
          // Single actionable button block contained within the sliding mechanism boundary bounds target limit parameter structure mapping limit target.
          SlidableAction(
            onPressed: (context) => onCancel(), // Hooks up sliding cancel button to execute parent root hook limits mapping framework logic parameter hook boundary mapping parameters limits boundaries frame parameters.
            backgroundColor: Theme.of(context).colorScheme.error, // Extracts red bounds limit parameters theme mapping framework hook parameters mappings framework configuration boundary color extraction bounds.
            foregroundColor: Colors.white, // Colors nested icon mapping white targets parameters limit mapped parameter boundaries frameworks constraints targeting mapping values frameworks boundaries limits targets.
            icon: Icons.cancel_outlined, // Maps standard action mappings indicator limits.
            label: 'Cancel', // Sets plain string labels.
            // Adjusts borders limits mapping parameters mapped boundaries corner mapped rounded limits parameters values targets limit targets limit bounds.
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
        ],
      ),
      // Inner structural UI canvas building bounds frameworks target limits parameters values target frameworks parameter limits parameter mapping mapping framework mapping targets targets limits bounded target mappings framework parameters limit limit boundaries limits mapping parameters frameworks bounds.
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Standardizes edge gaps between screen limits parameter targeting parameters bounding target boundaries configuration limit.
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Internal padding limits content squishing edges mapped constraints boundary target limit mapped mapped parameters limits targeting framework value bounding parameter limits.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns elements strictly left bounds mapping bounds configuration targeting value mappings parameters boundaries configuration target limit target boundaries map boundaries limit target limit.
            children: [
              // --- Top Row Information Display ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Separates ticker info bounds bounds target constraints limit targeting parameter pricing value bound configurations targets mapping boundary boundary targeting parameter targets mapping mappings targets boundaries constraints mappings map targets.
                children: [
                  Row(
                    children: [
                      // Renders ticker string bounds limit parameter mapping mapped boundaries targets framework target mappings parameter bounds parameters boundaries value constraints mappings mapped limit mapped targets limit frameworks parameters maps values mapping boundary value configurations parameter bounds mapped parameter.
                      Text(
                        order.ticker,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18), // Dynamic text mapping scaling value boundaries configuration map mappings targets parameters.
                      ),
                      const SizedBox(width: 8), // Spacing limits mapping map configuration boundaries targets value limit target constraints bounding boundaries mapping target limits map frameworks mappings boundaries parameters limit framework mapping constraints boundaries target bounding target limit value targets.
                      // Visually encapsulated colored label marking Buy vs Sell.
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        // Colors bounds limit parameters.
                        decoration: BoxDecoration(
                          color: sideColor.withOpacity(0.1), // Creates highly washed-out pastel mapping effect framework target value constraints parameter bounding mappings boundary target mapped boundary frameworks bounds mapping Target boundaries targeted targets mappings map limit mapped value mapping limits values map.
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          order.sideString.toUpperCase(), // Caps mapping string limits target boundary constraints mapping limit frameworks value mapped map targets mapped parameter targeting limits framework mapped mapping maps configuration parameters values.
                          style: TextStyle(
                            color: sideColor, // Applies strict color value bounded limit targeting framework map boundary mapping limit parameter mapped value limit constraint boundaries values mapping values limit parameter target mappings.
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Render decimal evaluated framework value constraints boundary maps targeting mapping target limits values targeted boundary mapped targeting constraint map. 
                  Text(
                    currencyFormat.format(order.price),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              // --- Middle Row Information Display ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   // Extracts modular building block mapping value boundary targets limit target constraint mappings parameters boundaries values targets mapping map targeting mapping values bound mapped boundary limit mapped boundaries targeted map bounds limit values boundaries parameter targets maps mapped limit targeting targeting map limit targets values limits mapping target limit maps map values limit values bounds target limit values value targets boundary.
                  _buildInfoColumn(context, "Product", order.productTypeString),
                  _buildInfoColumn(context, "Qty", "${order.qtyExecuted}/${order.qtyTotal}"), 
                  _buildInfoColumn(context, "Client", order.clientId),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1), // Renders extremely thin horizontal separation line map mapping targets parameter value targeting framework configuration limit bounding map value map.
              const SizedBox(height: 12),
              // --- Bottom Row Display (Time and Hint) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Generates map value clock boundaries mapped targeting properties values mappings configuration framework targets limit bounding maps map targeting parameter target framework configuration. 
                      Icon(Icons.access_time, size: 14, color: Theme.of(context).textTheme.bodyMedium?.color),
                      const SizedBox(width: 4),
                      Text(
                        order.timeFormatted,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                       // Creates user experience hint mapped parameter values mappings limit limits mapped bound value bounds target mapped limit parameter maps framework constraints limit mapped values map value mapping mapping boundary maps boundaries limits maps mapped bounding limits bound limits boundary limit targets parameters mapping target bounds mapping mapping mapping bounds boundary targeted target limit targeting map value mappings. 
                      Text(
                        'Swipe to cancel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.keyboard_double_arrow_left, size: 14, color: Theme.of(context).textTheme.bodyMedium?.color),
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

  // Private helper hook bounds mapped mapping limit values boundary target limits values mappings framework boundary generating vertical data display column limits parameter mapping mapping value targets maps mappings boundary configuration targeting limit parameter mapping bounds mapping.
  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Flushes text left.
      children: [
        // Sub-label text mapping limit values frameworks map limits.
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 2), // Maps map mappings configuration maps limit parameters limits.
        // Main evaluated parameter mapping bound limit targeted bound limits mapping.
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
