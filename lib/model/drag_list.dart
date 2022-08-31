//CLASS FOR THE LIST OF THE ITEM
class DraggableList{

final String header;
final List<DraggableListItem> items;

const DraggableList({
required this.header,
required this.items
});

}


//CLASS FOR THE ITEM
class DraggableListItem{
  final String title;
  final String urlImage;
  
  const DraggableListItem({
    required this.title,
    required this.urlImage
  });

}