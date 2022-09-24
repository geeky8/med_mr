class AddressModel {
  AddressModel({
    required this.name,
    required this.id,
  });

  factory AddressModel.fromJson({required String name, required int id}) {
    return AddressModel(name: name, id: id);
  }

  final String name;
  final int id;
}
