library;

/// This method capitalizes the first letter of a name,
/// if the user provides it with a lowercase initial in their Gmail address.

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
