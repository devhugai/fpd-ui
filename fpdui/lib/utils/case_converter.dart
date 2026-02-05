// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:math';

/// A utility class for converting text strings into various casing formats.
///
/// It handles normalization of input, extraction of words, and applies
/// specific transformations for each case, preserving accented characters
/// and numbers within words.
class TextCaseConverter {
  /// Internal helper to normalize the input string based on general rules.
  ///
  /// - Trims leading/trailing spaces.
  /// - Replacess multiple spaces with a single space.
  /// - Preserves only letters, numbers, and word separators.
  static String _normalizeInput(String input) {
    // Trim leading/trailing spaces
    String normalized = input.trim();

    // Replace multiple spaces with a single space
    normalized = normalized.replaceAll(RegExp(r'\s+'), ' ');

    // Preserve only letters (P{L}), numbers (P{N}), and word separators (space, _, -, ., /)
    // All other characters are removed.
    normalized = normalized.replaceAllMapped(
      RegExp(r'[^\p{L}\p{N}\s_\-./]', unicode: true),
      (match) => '',
    );

    return normalized;
  }

  /// Internal helper to extract words from a normalized string.
  ///
  /// Words are identified by spaces, `_`, `-`, `.`, `/`, and case boundaries.
  static List<String> _getWords(String normalizedInput) {
    if (normalizedInput.isEmpty) return [];

    // Step 1: Replace all specified separators with a single space to unify splitting.
    // This also handles cases where there are multiple separators together like "word--word"
    String tempSeparated = normalizedInput
        .replaceAll(RegExp(r'[_\-./]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ') // Consolidate multiple spaces again
        .trim(); // Trim any new leading/trailing spaces from separator replacement

    // Step 2: Split by spaces to get initial segments.
    final List<String> initialSegments = tempSeparated.split(' ');

    // Step 3: Further split segments based on camelCase/PascalCase boundaries.
    final List<String> finalWords = [];
    for (final segment in initialSegments) {
      if (segment.isEmpty) continue;

      final StringBuffer currentWordBuffer = StringBuffer();
      for (int i = 0; i < segment.length; i++) {
        final char = segment[i];

        if (i > 0 &&
            // Check for uppercase letter following a lowercase one (camelCase boundary)
            char.toUpperCase() == char && // Is uppercase
            char.toLowerCase() != char && // Is not a symbol that's same in upper/lower
            segment[i - 1].toLowerCase() == segment[i - 1] // Previous is lowercase
            ) {
          if (currentWordBuffer.isNotEmpty) {
            finalWords.add(currentWordBuffer.toString());
            currentWordBuffer.clear();
          }
        }
        currentWordBuffer.write(char);
      }
      if (currentWordBuffer.isNotEmpty) {
        finalWords.add(currentWordBuffer.toString());
      }
    }
    // Return all words in their original casing as extracted,
    // individual case functions will handle final casing.
    return finalWords;
  }

  /// Converts all characters to lowercase, preserving spaces.
  static String toLowerCase(String text) {
    final normalized = _normalizeInput(text);
    return normalized.toLowerCase();
  }

  /// Converts all characters to uppercase, preserving spaces.
  static String toUpperCase(String text) {
    final normalized = _normalizeInput(text);
    return normalized.toUpperCase();
  }

  /// Converts to camelCase: first word lowercase, subsequent words capitalized, no separators.
  static String toCamelCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    final StringBuffer buffer = StringBuffer();
    buffer.write(words[0].toLowerCase());
    for (int i = 1; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        buffer.write(
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase());
      }
    }
    return buffer.toString();
  }

  /// Capitalizes the first letter of every word, words separated by a single space.
  static String toCapitalCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Converts to CONSTANT_CASE: all letters uppercase, words separated by underscore.
  static String toConstantCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) => word.toUpperCase()).join('_');
  }

  /// Converts to dot.case: all letters lowercase, words separated by dot.
  static String toDotCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) => word.toLowerCase()).join('.');
  }

  /// Converts to Header-Case: capitalize first letter of each word, words separated by hyphen.
  static String toHeaderCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join('-');
  }

  /// Converts to no case: all letters lowercase, words separated by spaces.
  /// Same as normalized lowercase text.
  static String toNoCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) => word.toLowerCase()).join(' ');
  }

  /// Converts to param-case: all letters lowercase, words separated by hyphen.
  static String toParamCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) => word.toLowerCase()).join('-');
  }

  /// Converts to PascalCase: capitalize first letter of every word, no separators.
  static String toPascalCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join('');
  }

  /// Converts to path/case: all letters lowercase, words separated by slash.
  static String toPathCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) => word.toLowerCase()).join('/');
  }

  /// Converts to Sentence case: first letter of the sentence uppercase, rest lowercase,
  /// words separated by spaces.
  static String toSentenceCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    final String sentence = words.map((word) => word.toLowerCase()).join(' ');
    if (sentence.isEmpty) return ''; // Handle case where sentence is empty after join
    return sentence[0].toUpperCase() + sentence.substring(1);
  }

  /// Converts to snake_case: all letters lowercase, words separated by underscore.
  static String toSnakeCase(String text) {
    final words = _getWords(_normalizeInput(text));
    if (words.isEmpty) return '';

    return words.map((word) => word.toLowerCase()).join('_');
  }

  /// Converts to MoCkInG cAsE: alternates uppercase/lowercase letters by pattern.
  /// Even index letters become uppercase, odd index letters become lowercase.
  /// Spaces are preserved.
  static String toMockingCase(String text) {
    final normalized = _normalizeInput(text);
    final StringBuffer result = StringBuffer();
    bool toUpper = true; // Start with uppercase for the first letter

    for (int i = 0; i < normalized.length; i++) {
      final char = normalized[i];
      if (char == ' ') {
        result.write(char);
      } else {
        result.write(toUpper ? char.toUpperCase() : char.toLowerCase());
        toUpper = !toUpper; // Alternate for the next letter
      }
    }
    return result.toString();
  }
}