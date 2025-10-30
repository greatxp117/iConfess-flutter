import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../component_example_interface.dart' as example_interface;

class TableExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Table';

  @override
  String get description => 'Structured way to display tabular data';

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.intermediate;

  @override
  String get category => 'Data';

  @override
  List<String> get tags => ['data', 'table', 'tabular', 'grid'];

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Invoices': example_interface.ComponentVariant(
          previewBuilder: (context) => const InvoicesTableExample(),
          code: _getInvoicesCode(),
        ),
        'Users': example_interface.ComponentVariant(
          previewBuilder: (context) => const UsersTableExample(),
          code: _getUsersCode(),
        ),
        'Products': example_interface.ComponentVariant(
          previewBuilder: (context) => const ProductsTableExample(),
          code: _getProductsCode(),
        ),
        'Custom Table': example_interface.ComponentVariant(
          previewBuilder: (context) => const CustomTableExample(),
          code: _getCustomCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final key = variantKey ?? variants.keys.first;
    return variants[key]!.previewBuilder(context);
  }

  @override
  String getCode([String? variantKey]) {
    final key = variantKey ?? variants.keys.first;
    return variants[key]!.code;
  }

  String _getInvoicesCode() {
    return '''class InvoicesTableExample extends StatelessWidget {
  const InvoicesTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Invoices Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A table displaying invoice data with headers and footer totals.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 350, // Reduced to prevent overflow
          ),
          child: ShadTable.list(
            header: const [
              ShadTableCell.header(child: Text('Invoice')),
              ShadTableCell.header(child: Text('Status')),
              ShadTableCell.header(child: Text('Method')),
              ShadTableCell.header(
                alignment: Alignment.centerRight,
                child: Text('Amount'),
              ),
            ],
            footer: const [
              ShadTableCell.footer(child: Text('Total')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(
                alignment: Alignment.centerRight,
                child: Text(r'\$2500.00'),
              ),
            ],
            columnSpanExtent: (index) {
              if (index == 2) return const FixedTableSpanExtent(130);
              if (index == 3) {
                return const MaxTableSpanExtent(
                  FixedTableSpanExtent(120),
                  RemainingTableSpanExtent(),
                );
              }
              return null;
            },
            children: invoices.map(
              (invoice) => [
                ShadTableCell(
                  child: Text(
                    invoice.invoice,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(child: Text(invoice.paymentStatus)),
                ShadTableCell(child: Text(invoice.paymentMethod)),
                ShadTableCell(
                  alignment: Alignment.centerRight,
                  child: Text(invoice.totalAmount),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const invoices = [
  (
    invoice: "INV001",
    paymentStatus: "Paid",
    totalAmount: r"\$250.00",
    paymentMethod: "Credit Card",
  ),
  (
    invoice: "INV002",
    paymentStatus: "Pending",
    totalAmount: r"\$150.00",
    paymentMethod: "PayPal",
  ),
  (
    invoice: "INV003",
    paymentStatus: "Unpaid",
    totalAmount: r"\$350.00",
    paymentMethod: "Bank Transfer",
  ),
  (
    invoice: "INV004",
    paymentStatus: "Paid",
    totalAmount: r"\$450.00",
    paymentMethod: "Credit Card",
  ),
  (
    invoice: "INV005",
    paymentStatus: "Paid",
    totalAmount: r"\$550.00",
    paymentMethod: "PayPal",
  ),
  (
    invoice: "INV006",
    paymentStatus: "Pending",
    totalAmount: r"\$200.00",
    paymentMethod: "Bank Transfer",
  ),
  (
    invoice: "INV007",
    paymentStatus: "Unpaid",
    totalAmount: r"\$300.00",
    paymentMethod: "Credit Card",
  ),
];''';
  }

  String _getUsersCode() {
    return '''class UsersTableExample extends StatelessWidget {
  const UsersTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Users Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A table displaying user data with status indicators.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 350, // Reduced to prevent overflow
          ),
          child: ShadTable.list(
            header: const [
              ShadTableCell.header(child: Text('Name')),
              ShadTableCell.header(child: Text('Email')),
              ShadTableCell.header(child: Text('Status')),
              ShadTableCell.header(child: Text('Role')),
            ],
            children: users.map(
              (user) => [
                ShadTableCell(
                  child: Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(child: Text(user.email)),
                ShadTableCell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: user.status == 'Active' 
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      user.status,
                      style: TextStyle(
                        color: user.status == 'Active' 
                            ? Colors.green 
                            : Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                ShadTableCell(child: Text(user.role)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const users = [
  (name: "John Doe", email: "john@example.com", status: "Active", role: "Admin"),
  (name: "Jane Smith", email: "jane@example.com", status: "Active", role: "User"),
  (name: "Bob Johnson", email: "bob@example.com", status: "Inactive", role: "User"),
  (name: "Alice Brown", email: "alice@example.com", status: "Active", role: "Moderator"),
  (name: "Charlie Wilson", email: "charlie@example.com", status: "Inactive", role: "User"),
];''';
  }

  String _getProductsCode() {
    return '''class ProductsTableExample extends StatelessWidget {
  const ProductsTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Products Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A table displaying product data with pricing information.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 350, // Reduced to prevent overflow
          ),
          child: ShadTable.list(
            header: const [
              ShadTableCell.header(child: Text('Product')),
              ShadTableCell.header(child: Text('Category')),
              ShadTableCell.header(child: Text('Stock')),
              ShadTableCell.header(
                alignment: Alignment.centerRight,
                child: Text('Price'),
              ),
            ],
            footer: const [
              ShadTableCell.footer(child: Text('Total Products')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(
                alignment: Alignment.centerRight,
                child: Text('5'),
              ),
            ],
            children: products.map(
              (product) => [
                ShadTableCell(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(child: Text(product.category)),
                ShadTableCell(
                  child: Text(
                    product.stock.toString(),
                    style: TextStyle(
                      color: product.stock > 10 
                          ? Colors.green 
                          : product.stock > 0 
                              ? Colors.orange 
                              : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(
                  alignment: Alignment.centerRight,
                  child: Text(
                    product.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

''';
  }

  String _getCustomCode() {
    return '''class CustomTableExample extends StatelessWidget {
  const CustomTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A custom table with advanced styling and interactions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 350, // Reduced to prevent overflow
            ),
            child: ShadTable.list(
              header: const [
                ShadTableCell.header(child: Text('Task')),
                ShadTableCell.header(child: Text('Priority')),
                ShadTableCell.header(child: Text('Due Date')),
                ShadTableCell.header(child: Text('Actions')),
              ],
              children: tasks.map(
                (task) => [
                  ShadTableCell(
                    child: Text(
                      task.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ShadTableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: task.priority == 'High' 
                            ? Colors.red.withValues(alpha: 0.1)
                            : task.priority == 'Medium'
                                ? Colors.orange.withValues(alpha: 0.1)
                                : Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        task.priority,
                        style: TextStyle(
                          color: task.priority == 'High' 
                              ? Colors.red 
                              : task.priority == 'Medium'
                                  ? Colors.orange 
                                  : Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ShadTableCell(child: Text(task.dueDate)),
                  ShadTableCell(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShadButton.outline(
                          child: const Text('Edit'),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        ShadButton.destructive(
                          child: const Text('Delete'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const tasks = [
  (name: "Complete project", priority: "High", dueDate: "2024-01-15"),
  (name: "Review code", priority: "Medium", dueDate: "2024-01-20"),
  (name: "Update documentation", priority: "Low", dueDate: "2024-01-25"),
  (name: "Fix bugs", priority: "High", dueDate: "2024-01-10"),
  (name: "Write tests", priority: "Medium", dueDate: "2024-01-18"),
];''';
  }
}

// Widget implementations
class InvoicesTableExample extends StatelessWidget {
  const InvoicesTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Invoices Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A table displaying invoice data with headers and footer totals.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 350, // Reduced to prevent overflow
          ),
          child: ShadTable.list(
            header: const [
              ShadTableCell.header(child: Text('Invoice')),
              ShadTableCell.header(child: Text('Status')),
              ShadTableCell.header(child: Text('Method')),
              ShadTableCell.header(
                alignment: Alignment.centerRight,
                child: Text('Amount'),
              ),
            ],
            footer: const [
              ShadTableCell.footer(child: Text('Total')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(
                alignment: Alignment.centerRight,
                child: Text(r'$2500.00'),
              ),
            ],
            columnSpanExtent: (index) {
              if (index == 2) return const FixedTableSpanExtent(130);
              if (index == 3) {
                return const MaxTableSpanExtent(
                  FixedTableSpanExtent(120),
                  RemainingTableSpanExtent(),
                );
              }
              return null;
            },
            children: invoices.map(
              (invoice) => [
                ShadTableCell(
                  child: Text(
                    invoice.invoice,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(child: Text(invoice.paymentStatus)),
                ShadTableCell(child: Text(invoice.paymentMethod)),
                ShadTableCell(
                  alignment: Alignment.centerRight,
                  child: Text(invoice.totalAmount),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UsersTableExample extends StatelessWidget {
  const UsersTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Users Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A table displaying user data with status indicators.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 350, // Reduced to prevent overflow
          ),
          child: ShadTable.list(
            header: const [
              ShadTableCell.header(child: Text('Name')),
              ShadTableCell.header(child: Text('Email')),
              ShadTableCell.header(child: Text('Status')),
              ShadTableCell.header(child: Text('Role')),
            ],
            children: users.map(
              (user) => [
                ShadTableCell(
                  child: Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(child: Text(user.email)),
                ShadTableCell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: user.status == 'Active'
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      user.status,
                      style: TextStyle(
                        color: user.status == 'Active'
                            ? Colors.green
                            : Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                ShadTableCell(child: Text(user.role)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProductsTableExample extends StatelessWidget {
  const ProductsTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Products Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A table displaying product data with pricing information.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 350, // Reduced to prevent overflow
          ),
          child: ShadTable.list(
            header: const [
              ShadTableCell.header(child: Text('Product')),
              ShadTableCell.header(child: Text('Category')),
              ShadTableCell.header(child: Text('Stock')),
              ShadTableCell.header(
                alignment: Alignment.centerRight,
                child: Text('Price'),
              ),
            ],
            footer: const [
              ShadTableCell.footer(child: Text('Total Products')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(child: Text('')),
              ShadTableCell.footer(
                alignment: Alignment.centerRight,
                child: Text('5'),
              ),
            ],
            children: products.map(
              (product) => [
                ShadTableCell(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(child: Text(product.category)),
                ShadTableCell(
                  child: Text(
                    product.stock.toString(),
                    style: TextStyle(
                      color: product.stock > 10
                          ? Colors.green
                          : product.stock > 0
                              ? Colors.orange
                              : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShadTableCell(
                  alignment: Alignment.centerRight,
                  child: Text(
                    product.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTableExample extends StatelessWidget {
  const CustomTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Custom Table',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A custom table with advanced styling and interactions.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 350, // Reduced to prevent overflow
            ),
            child: ShadTable.list(
              header: const [
                ShadTableCell.header(child: Text('Task')),
                ShadTableCell.header(child: Text('Priority')),
                ShadTableCell.header(child: Text('Due Date')),
                ShadTableCell.header(child: Text('Actions')),
              ],
              children: tasks.map(
                (task) => [
                  ShadTableCell(
                    child: Text(
                      task.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ShadTableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: task.priority == 'High'
                            ? Colors.red.withValues(alpha: 0.1)
                            : task.priority == 'Medium'
                                ? Colors.orange.withValues(alpha: 0.1)
                                : Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        task.priority,
                        style: TextStyle(
                          color: task.priority == 'High'
                              ? Colors.red
                              : task.priority == 'Medium'
                                  ? Colors.orange
                                  : Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ShadTableCell(child: Text(task.dueDate)),
                  ShadTableCell(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShadButton.outline(
                          child: const Text('Edit'),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        ShadButton.destructive(
                          child: const Text('Delete'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Sample data
const invoices = [
  (
    invoice: "INV001",
    paymentStatus: "Paid",
    totalAmount: r"$250.00",
    paymentMethod: "Credit Card",
  ),
  (
    invoice: "INV002",
    paymentStatus: "Pending",
    totalAmount: r"$150.00",
    paymentMethod: "PayPal",
  ),
  (
    invoice: "INV003",
    paymentStatus: "Unpaid",
    totalAmount: r"$350.00",
    paymentMethod: "Bank Transfer",
  ),
  (
    invoice: "INV004",
    paymentStatus: "Paid",
    totalAmount: r"$450.00",
    paymentMethod: "Credit Card",
  ),
  (
    invoice: "INV005",
    paymentStatus: "Paid",
    totalAmount: r"$550.00",
    paymentMethod: "PayPal",
  ),
  (
    invoice: "INV006",
    paymentStatus: "Pending",
    totalAmount: r"$200.00",
    paymentMethod: "Bank Transfer",
  ),
  (
    invoice: "INV007",
    paymentStatus: "Unpaid",
    totalAmount: r"$300.00",
    paymentMethod: "Credit Card",
  ),
];

const users = [
  (
    name: "John Doe",
    email: "john@example.com",
    status: "Active",
    role: "Admin"
  ),
  (
    name: "Jane Smith",
    email: "jane@example.com",
    status: "Active",
    role: "User"
  ),
  (
    name: "Bob Johnson",
    email: "bob@example.com",
    status: "Inactive",
    role: "User"
  ),
  (
    name: "Alice Brown",
    email: "alice@example.com",
    status: "Active",
    role: "Moderator"
  ),
  (
    name: "Charlie Wilson",
    email: "charlie@example.com",
    status: "Inactive",
    role: "User"
  ),
];

const products = [
  (name: "Laptop", category: "Electronics", stock: 15, price: r"$999.99"),
  (name: "Mouse", category: "Electronics", stock: 8, price: r"$29.99"),
  (name: "Keyboard", category: "Electronics", stock: 0, price: r"$79.99"),
  (name: "Monitor", category: "Electronics", stock: 12, price: r"$299.99"),
  (name: "Headphones", category: "Audio", stock: 20, price: r"$149.99"),
];

const tasks = [
  (name: "Complete project", priority: "High", dueDate: "2024-01-15"),
  (name: "Review code", priority: "Medium", dueDate: "2024-01-20"),
  (name: "Update documentation", priority: "Low", dueDate: "2024-01-25"),
  (name: "Fix bugs", priority: "High", dueDate: "2024-01-10"),
  (name: "Write tests", priority: "Medium", dueDate: "2024-01-18"),
];
