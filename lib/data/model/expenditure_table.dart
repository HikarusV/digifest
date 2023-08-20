class ExpenditureTable {
  final int? id;
  final DateTime? tanggal;
  final int? jumlah;
  final String? description;

  const ExpenditureTable({
    this.id,
    required this.tanggal,
    required this.jumlah,
    required this.description,
  });

  factory ExpenditureTable.fromMap(Map<String, dynamic> map) =>
      ExpenditureTable(
        id: map['id'],
        tanggal: DateTime.tryParse(map['tanggal']),
        jumlah: map['jumlah'],
        description: map['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tanggal': tanggal.toString(),
        'jumlah': jumlah,
        'description': description,
      };

  Map<String, dynamic> toJsonEdited() => {
        'tanggal': tanggal.toString(),
        'jumlah': jumlah,
        'description': description,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, tanggal, jumlah, description];
}
