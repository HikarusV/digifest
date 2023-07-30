class AllowanceTable {
  final int? id;
  final DateTime? tanggal;
  final int? jumlah;
  final String? categories;

  const AllowanceTable({
    this.id,
    required this.tanggal,
    required this.jumlah,
    required this.categories,
  });

  factory AllowanceTable.fromMap(Map<String, dynamic> map) => AllowanceTable(
        id: map['id'],
        tanggal: DateTime.tryParse(map['tanggal']),
        jumlah: map['jumlah'],
        categories: map['categories'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tanggal': tanggal.toString(),
        'jumlah': jumlah,
        'categories': categories,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, tanggal, jumlah, categories];
}
