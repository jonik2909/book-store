class BookValidator {
  static String? validateBookName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Book name is required';
    }
    if (value.trim().length < 2) {
      return 'Book name must be at least 2 characters long';
    }
    if (value.trim().length > 100) {
      return 'Book name must not exceed 100 characters';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final price = int.tryParse(value.trim());
    if (price == null) {
      return 'Please enter numbers only';
    }
    if (price <= 0) {
      return 'Price must be greater than 0';
    }
    if (price > 1000000) {
      return 'Price is too high';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 4) {
      return 'Description must be at least 4 characters long';
    }
    if (value.trim().length > 1000) {
      return 'Description must not exceed 1000 characters';
    }
    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Category selection is required';
    }
    return null;
  }

  static String? validateImages(List<dynamic> images) {
    if (images.isEmpty) {
      return 'At least one image must be uploaded';
    }
    if (images.length > 3) {
      return 'Maximum 3 images can be uploaded';
    }
    return null;
  }
}
