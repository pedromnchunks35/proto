//CLASS ROUTE
class Route{
//THE VARS
int id;
String name;
int state;
/* LIST OF STATES
state = 0 -> RASCUNHO
state = 1 -> ATIVADA
state = 2 -> FEITA
*/ 

String start_date;
String end_date;

//THE CONSTRUCTOR
Route({
required this.id,
required this.name,
required this.state,
required this.start_date,
required this.end_date
});
}



//CLASS Leaf
class Leaf{
//VARS
int id_route;
int id_poi;
//CONSTRUCTOR
Leaf({
required this.id_route,
required this.id_poi
});
}


