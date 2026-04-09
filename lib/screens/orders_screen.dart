// Imports Flutter's standard Material design components.
import 'package:flutter/material.dart';
// Imports our data model detailing what constitutes a TradeOrder.
import '../models/order.dart';
// Imports the horizontally scrollable filter selection bar.
import '../widgets/filter_chips.dart';
// Imports the customized visual component mapping out a singular stock order.
import '../widgets/order_card.dart';
// Imports our customized textfield acting as a search bar.
import '../widgets/search_input.dart';

// The structural screen housing all sub-components. Created as a StatefulWidget
// because it must handle real-time changes to the state (filtering, pagination, deleting).
class OrdersScreen extends StatefulWidget {
  // Const constructor for performance optimization.
  const OrdersScreen({super.key});

  @override
  // Connects the StatefulWidget framework to its state class body.
  State<OrdersScreen> createState() => _OrdersScreenState();
}

// Contains the private reactive state handling data manipulation and layout rendering.
class _OrdersScreenState extends State<OrdersScreen> {
  // Tracks which categorical filter is currently active in the UI. Defaults to 'All'.
  String _currentFilter = 'All';
  // Tracks exactly which page of data the user is viewing. Defaults to index 1.
  int _currentPage = 1;
  // A hardcoded limit defining how many data cards should fit on a page.
  final int _itemsPerPage = 5;

  // Recreates our hard-coded model dataset inside state, so that we can freely
  // manipulate (cancel) items without wiping out the core data model blueprint array.
  List<TradeOrder> _orders = List.from(sampleOrders);

  // A dynamically calculated getter property that returns the subset of orders matching 
  // the user's currently selected criteria, to be sent down to the UI rendering loop.
  List<TradeOrder> get _filteredOrders {
    // Start with the full list.
    List<TradeOrder> filtered = _orders;
    
    // If the filter isn't "All", apply narrowing conditions based on the string.
    if (_currentFilter != 'All') {
      if (_currentFilter == 'Buy') {
        // Keep elements strictly tagged as 'buy' side.
        filtered = filtered.where((o) => o.side == OrderSide.buy).toList();
      } else if (_currentFilter == 'Sell') {
        // Keep elements strictly tagged as 'sell' side.
        filtered = filtered.where((o) => o.side == OrderSide.sell).toList();
      } else if (_currentFilter == 'CNC') {
        // Keep elements strictly tagged under product category CNC.
        filtered = filtered.where((o) => o.product == ProductType.cnc).toList();
      } else if (_currentFilter == 'NRML') {
        // Keep elements strictly tagged under product category NRML.
        filtered = filtered.where((o) => o.product == ProductType.nrml).toList();
      }
    }
    // Return the resulting cut list.
    return filtered;
  }

  // An action method fired locally when a child card reports it was swiped for 'Cancel'.
  void _cancelOrder(TradeOrder order) {
    // Triggers a UI rebuild globally on this screen.
    setState(() {
      // Deletes the individual object from the main reactive list.
      _orders.remove(order);
    });
    // Triggers a tiny popup banner at the bottom notifying the user of success.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order for ${order.ticker} cancelled.'), // Interpolated success message.
        behavior: SnackBarBehavior.floating, // Floats above elements instead of sticking to hard-bottom edge.
      ),
    );
  }

  // Fired by the Global 'Cancel All' Appbar button.
  void _cancelAll() {
    // Commands the flutter framework to throw up an alert modal dialog in the middle of the screen.
    showDialog(
      context: context,
      builder: (context) => AlertDialog( // Construct an AlertDialog UI block
        title: const Text('Cancel All Orders?'), // Dialogue title
        content: const Text('Are you sure you want to cancel all open orders?'), // Warning text
        // Contains interactive buttons at bottom edge of dialogue modal
        actions: [
          // Basic text button to abort action.
          TextButton(
            // Kills the dialogue popup by popping the route stack context backward.
            onPressed: () => Navigator.pop(context), 
            child: const Text('No'),
          ),
          // Destructive colored button to finalize decision
          FilledButton(
            onPressed: () {
              // Notify framework that UI needs a rebuild
              setState(() {
                // Completely empty the tracked order list memory array.
                _orders.clear();
              });
              // Kills the dialogue popup.
              Navigator.pop(context);
            },
            // Explicitly styles the background of this button to map to the App's "Error" (Red) semantic color.
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Cancel All'),
          ),
        ],
      ),
    );
  }

  @override
  // Defines exactly what visual architecture is painted inside this route.
  Widget build(BuildContext context) {
    // Calculates what the active orders look like once passed through the filter parameters.
    final activeOrders = _filteredOrders;
    
    // Pagination Mathematical Logic:
    // Finds total pages by dividing total returned items by items-per-page constant and rounding up. Defaults to 1 if 0.
    final totalPages = (activeOrders.length / _itemsPerPage).ceil() == 0 ? 1 : (activeOrders.length / _itemsPerPage).ceil();
    // Identifies index location of first item based on what page we're viewing.
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    // Identifies index location of last item. Constrains calculation so it doesn't overrun the array length.
    final endIndex = (startIndex + _itemsPerPage > activeOrders.length) ? activeOrders.length : startIndex + _itemsPerPage;
    // Creates a slice (sublist) of the filtered array representing JUST the data we want to render physically.
    final displayedOrders = activeOrders.sublist(startIndex, endIndex);

    return Scaffold( // Base canvas for the entire screen route hierarchy.
      appBar: AppBar( // Builds the top-most header structure.
        title: const Text('Open Orders'), // Screen title name.
        // Array of widgets mapped to the trailing (right) edge of the appbar.
        actions: [
          // Conditionally renders a button only if there are actually orders left to delete.
          if (_orders.isNotEmpty)
            // Wrap in padding so it doesn't touch the immediate screen edge.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              // Helper widget assembling an icon and strict label into a block.
              child: FilledButton.icon(
                onPressed: _cancelAll, // Connects to local method
                icon: const Icon(Icons.cancel, size: 18), // Visual red 'x' mapping
                label: const Text('Cancel All'), // Human-read intent.
                // Button styling
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error, // Extracts the 'Sell/Red' theme color.
                  foregroundColor: Colors.white, // Colors font and icon white.
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Round corners slightly.
                ),
              ),
            ),
        ],
      ),
      // Starts painting the body top down underneath the Appbar.
      body: Column(
        children: [
          const SizedBox(height: 8), // Small empty space buffer.
          const SearchInput(), // Integrates our textfield widget placeholder
          const SizedBox(height: 8), // Another small buffer
          // Passes in the array of filter words and registers a callback hook when a filter is flipped.
          FilterChipsSection(
            filters: const ['All', 'Buy', 'Sell', 'CNC', 'NRML'],
            onFilterSelected: (filter) {
               // When a child requests a filter change, update state
              setState(() {
                _currentFilter = filter; // Point to new filter requirement
                _currentPage = 1; // Safely bounce user back to page 1 for proper UX handling
              });
            },
          ),
          const SizedBox(height: 8),
          // Expanded forces ListView/List blocks to claim ALL remaining dynamic vertical free space.
          Expanded( 
            // Ternary condition rendering empty screen logic OR the data list map.
            child: displayedOrders.isEmpty
                ? _buildEmptyState() // Injects empty state UI if calculations produced 0 items.
                : ListView.builder( // Employs performance-safe mapping looping engine for Flutter arrays.
                    itemCount: displayedOrders.length, // Dictates how many items framework should compute.
                    // Loop hook building actual UI block per sublist item mapped to an integer layout position.
                    itemBuilder: (context, index) {
                      final order = displayedOrders[index]; // Extract explicit object model.
                      // Constructs the custom card visual widget, passing data downward.
                      return OrderCard(
                        order: order, // Mapping data chunk
                        onCancel: () => _cancelOrder(order), // Giving card block a pointer hook to cancel its own data up the tree.
                      );
                    },
                  ),
          ),
          // Conditionally inject pagination dock at the absolutely lowest structural edge, if data exists.
          if (activeOrders.isNotEmpty) _buildPagination(totalPages),
        ],
      ),
    );
  }

  // A private widget building helper containing the visual layout for 'No data available'.
  Widget _buildEmptyState() {
    // Aligns content exactly in dead-center of column bounds.
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Gravity setting center vertical.
        children: [
          // Empty inbox icon imagery.
          Icon(
            Icons.inbox_outlined,
            size: 80, // Extremely large indicator.
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5), // Maps to muted gray and reduces opacity safely.
          ),
          const SizedBox(height: 16), // Margin spacer
          // Main empty text directive.
          Text(
            "No Open Orders",
            style: Theme.of(context).textTheme.titleLarge, // Using pre-configured header sizing from app_theme context pool.
          ),
          const SizedBox(height: 8), // Minor margin spacer
          // Secondary directional explanation text.
          Text(
            "There are currently no orders \nmatching your filters.",
            textAlign: TextAlign.center, // Center string orientation on multi-line break.
            style: Theme.of(context).textTheme.bodyMedium, // Use small muted textual map from context pool.
          ),
        ],
      ),
    );
  }

  // A private widget building helper returning standard pagination navigation at the lowest route edge.
  Widget _buildPagination(int totalPages) {
    // Draw an encapsulating block providing background color boundaries and padding.
    return Container(
      padding: const EdgeInsets.all(16.0), // Give interior elements breathing room against edges.
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor, // Reconnect background to matching theme mode.
        boxShadow: [
          // Drops a reverse-shadow upwards to demarcate list scroll limits visually from navigation controls.
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4), // Shifting shadow up slightly.
            blurRadius: 8, // Softening the line cast.
          ),
        ],
      ),
      // SafeArea avoids OS navigation bars, ensuring UI stays in touchable interactive space limits.
      child: SafeArea(
        top: false, // Disables avoidance over layout top so it stays glued perfectly aligned underneath list container bounding edge.
        child: Row( // Horizontally space out items.
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Throw left/right elements max distance to far edge confines.
          children: [
            // Outlined styled UI interactive boundary button.
            OutlinedButton(
               // Only register a tap interaction hook if current page isn't equal to 1. Else sets button to disabled automatically (null).
              onPressed: _currentPage > 1
                  ? () {
                      setState(() {
                         // Decouples and subtracts current target page tracking by integer value 1 point.
                        _currentPage--;
                      });
                    }
                  : null, // Hardcoded disable value trigger.
              child: const Text('Previous'), // Human Label string representation.
            ),
            // Middle component labeling current mathematical execution map position value coordinates.
            Text(
               // Interweaving string inputs into visual sentence output using String Interpolation mapping variables `$xx`.
              'Page $_currentPage of $totalPages',
              style: const TextStyle(fontWeight: FontWeight.w600), // Thickening text visually without relying fully on explicit Title theme values.
            ),
             // Opposite end target navigator mapped boundary UI container limits target trigger. 
            OutlinedButton(
               // Verifies we have not bypassed the mapped ceiling limit of available mathematical boundaries.
              onPressed: _currentPage < totalPages
                  ? () {
                      setState(() {
                         // Advance current track memory position targeting mapping. 
                        _currentPage++;
                      });
                    }
                  : null, 
              child: const Text('Next'), // Value command prompt.
            ),
          ],
        ),
      ),
    );
  }
}
