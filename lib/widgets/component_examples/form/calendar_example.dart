import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../component_example_interface.dart' as example_interface;

/// Calendar component implementation using the new architecture
class CalendarExample implements example_interface.ComponentExample {
  @override
  String get componentName => 'Calendar';

  @override
  String get description =>
      'A calendar component for date selection and scheduling.';

  @override
  String get category => 'Data & Visualization';

  @override
  List<String> get tags => ['calendar', 'date', 'time', 'scheduling'];

  @override
  example_interface.ComponentComplexity get complexity =>
      example_interface.ComponentComplexity.advanced;

  @override
  Map<String, example_interface.ComponentVariant> get variants => {
        'Single': example_interface.ComponentVariant(
          previewBuilder: (context) => const SingleCalendar(),
          code: _getSingleCode(),
        ),
        'Multiple': example_interface.ComponentVariant(
          previewBuilder: (context) => const MultipleCalendar(),
          code: _getMultipleCode(),
        ),
        'Range': example_interface.ComponentVariant(
          previewBuilder: (context) => const RangeCalendar(),
          code: _getRangeCode(),
        ),
        'Dropdown Months': example_interface.ComponentVariant(
          previewBuilder: (context) => const DropdownMonthsCalendar(),
          code: _getDropdownMonthsCode(),
        ),
        'Dropdown Years': example_interface.ComponentVariant(
          previewBuilder: (context) => const DropdownYearsCalendar(),
          code: _getDropdownYearsCode(),
        ),
        'Hide Navigation': example_interface.ComponentVariant(
          previewBuilder: (context) => const HideNavigationCalendar(),
          code: _getHideNavigationCode(),
        ),
        'Show Week Numbers': example_interface.ComponentVariant(
          previewBuilder: (context) => const ShowWeekNumbersCalendar(),
          code: _getShowWeekNumbersCode(),
        ),
      };

  @override
  Widget buildPreview(BuildContext context, [String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.previewBuilder(context) ?? const SizedBox();
  }

  @override
  String getCode([String? variantKey]) {
    final variant = variants[variantKey ?? variants.keys.first];
    return variant?.code ?? '';
  }

  // Code examples from the original CalendarExample
  String _getSingleCode() {
    return '''class SingleCalendar extends StatefulWidget {
  const SingleCalendar({super.key});

  @override
  State<SingleCalendar> createState() => _SingleCalendarState();
}

class _SingleCalendarState extends State<SingleCalendar> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      mode: ShadCalendarMode.single,
      selected: selectedDate,
      onSelected: (date) {
        setState(() {
          selectedDate = date;
        });
      },
    );
  }
}''';
  }

  String _getMultipleCode() {
    return '''class MultipleCalendar extends StatefulWidget {
  const MultipleCalendar({super.key});

  @override
  State<MultipleCalendar> createState() => _MultipleCalendarState();
}

class _MultipleCalendarState extends State<MultipleCalendar> {
  List<DateTime> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      mode: ShadCalendarMode.multiple,
      selected: selectedDates,
      onSelected: (dates) {
        setState(() {
          selectedDates = dates;
        });
      },
    );
  }
}''';
  }

  String _getRangeCode() {
    return '''class RangeCalendar extends StatefulWidget {
  const RangeCalendar({super.key});

  @override
  State<RangeCalendar> createState() => _RangeCalendarState();
}

class _RangeCalendarState extends State<RangeCalendar> {
  DateTimeRange? selectedRange;

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      mode: ShadCalendarMode.range,
      selected: selectedRange,
      onSelected: (range) {
        setState(() {
          selectedRange = range;
        });
      },
    );
  }
}''';
  }

  String _getDropdownMonthsCode() {
    return '''class DropdownMonthsCalendar extends StatefulWidget {
  const DropdownMonthsCalendar({super.key});

  @override
  State<DropdownMonthsCalendar> createState() => _DropdownMonthsCalendarState();
}

class _DropdownMonthsCalendarState extends State<DropdownMonthsCalendar> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      mode: ShadCalendarMode.single,
      selected: selectedDate,
      onSelected: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      showMonthDropdown: true,
    );
  }
}''';
  }

  String _getDropdownYearsCode() {
    return '''class DropdownYearsCalendar extends StatefulWidget {
  const DropdownYearsCalendar({super.key});

  @override
  State<DropdownYearsCalendar> createState() => _DropdownYearsCalendarState();
}

class _DropdownYearsCalendarState extends State<DropdownYearsCalendar> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      mode: ShadCalendarMode.single,
      selected: selectedDate,
      onSelected: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      showYearDropdown: true,
    );
  }
}''';
  }

  String _getHideNavigationCode() {
    return '''class HideNavigationCalendar extends StatefulWidget {
  const HideNavigationCalendar({super.key});

  @override
  State<HideNavigationCalendar> createState() => _HideNavigationCalendarState();
}

class _HideNavigationCalendarState extends State<HideNavigationCalendar> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      mode: ShadCalendarMode.single,
      selected: selectedDate,
      onSelected: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      showNavigation: false,
    );
  }
}''';
  }

  String _getShowWeekNumbersCode() {
    return '''class ShowWeekNumbersCalendar extends StatefulWidget {
  const ShowWeekNumbersCalendar({super.key});

  @override
  State<ShowWeekNumbersCalendar> createState() => _ShowWeekNumbersCalendarState();
}

class _ShowWeekNumbersCalendarState extends State<ShowWeekNumbersCalendar> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      mode: ShadCalendarMode.single,
      selected: selectedDate,
      onSelected: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      showWeekNumbers: true,
    );
  }
}''';
  }
}

// Widget implementations
class SingleCalendar extends StatefulWidget {
  const SingleCalendar({super.key});

  @override
  State<SingleCalendar> createState() => _SingleCalendarState();
}

class _SingleCalendarState extends State<SingleCalendar> {
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      selected: today,
      fromMonth: DateTime(today.year - 1),
      toMonth: DateTime(today.year, 12),
    );
  }
}

class MultipleCalendar extends StatefulWidget {
  const MultipleCalendar({super.key});

  @override
  State<MultipleCalendar> createState() => _MultipleCalendarState();
}

class _MultipleCalendarState extends State<MultipleCalendar> {
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ShadCalendar.multiple(
      numberOfMonths: 2,
      fromMonth: DateTime(today.year),
      toMonth: DateTime(today.year + 1, 12),
      min: 5,
      max: 10,
    );
  }
}

class RangeCalendar extends StatelessWidget {
  const RangeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadCalendar.range(
      min: 2,
      max: 5,
    );
  }
}

class DropdownMonthsCalendar extends StatelessWidget {
  const DropdownMonthsCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadCalendar(
      captionLayout: ShadCalendarCaptionLayout.dropdownMonths,
    );
  }
}

class DropdownYearsCalendar extends StatelessWidget {
  const DropdownYearsCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadCalendar(
      captionLayout: ShadCalendarCaptionLayout.dropdownYears,
    );
  }
}

class HideNavigationCalendar extends StatelessWidget {
  const HideNavigationCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadCalendar(
      hideNavigation: true,
    );
  }
}

class ShowWeekNumbersCalendar extends StatelessWidget {
  const ShowWeekNumbersCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadCalendar(
      showWeekNumbers: true,
    );
  }
}
