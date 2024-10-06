
import 'package:dinde_market/models/district.dart';
import 'package:dinde_market/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(
    id: 1, 
    firstName: 'John', 
    lastName: 'Doe', 
    phoneNumber: '+996 (707) 23 10 88', 
    region: District(id: 1, name: "", priceDelivery: 2),
    address: '',
    username: ''
  ));  // Initial user state

  // Method to update the user's first name
  void updateFirstName(String newFirstName) {
    state = state.copyWith(firstName: newFirstName);
  }

  // Method to update the user's last name
  void updateLastName(String newLastName) {
    state = state.copyWith(lastName: newLastName);
  }

  // Method to update the user's phone number
  void updatePhoneNumber(String newPhoneNumber) {
    state = state.copyWith(phoneNumber: newPhoneNumber);
  }

  // Method to update the user's region
  void updateRegion(District newRegion) {
    state = state.copyWith(region: newRegion);
  }

  void updateDistrict(String newDistrict) {
    state = state.copyWith(district: newDistrict);
  }

  void updateUsername(String newUsername) {
    state = state.copyWith(username: newUsername);
  }

  void updateAddress(String newAddress) {
    state = state.copyWith(addresss: newAddress);
  }

  // Method to update the whole user
  void updateUser(User updatedUser) {
    state = updatedUser;
  }
}

// Define the provider
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
