class MyCategory {
  MyCategory({ required this.fields, required this.free, required this.name, required this.postedBy});
  final String? name;
  final String? postedBy;
  final bool? free;
  final List? fields;
  MyCategory.fromJson(Map<String, dynamic> json): this(
    name: json['name']! as String,
    postedBy: json['postedBy']! as String,
    free: json['free']! as bool,
    fields: json['fields']! as List
  );
  Map<String, Object?> toJson() {
    return {
      'name': name,
      'postedBy': postedBy,
      'free': free,
      'fields': fields
    };
  }
}