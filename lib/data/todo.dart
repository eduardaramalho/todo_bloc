class Todo {
  final String title;
  final String subtitle;
  bool isDone;

  Todo({
    this.title = '',
    this.subtitle = '',
    this.isDone = false
  });

  Todo copyWith({
    String? title,
    String? subtitle,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone
    );
  }

  factory Todo.fromJson(Map <String, dynamic> data){
    return Todo(
      title: data['title'],
      subtitle: data['subtitle'],
      isDone: data['isDone']
    );
  }
    
  Map<String, dynamic> toJson(){
    return {
      'title' : title,
      'subtitle' : subtitle,
      'isDone' : isDone
    };
  }

  @override
  String toString(){
    return ''' Todo: { 
      title: $title\n 
      subtitle:$subtitle\n 
      isDone: $isDone\n 
      }''';
  }


}