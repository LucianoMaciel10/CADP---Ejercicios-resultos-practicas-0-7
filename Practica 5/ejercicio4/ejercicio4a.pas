{
  Indicar los valores que imprimen los siguientes programas en Pascal. Justificar mediante prueba de
  escritorio.
}
program punteros;
type
  cadena = string[50];
  puntero_cadena = ^cadena;
var
  pc: puntero_cadena;
begin
  pc^:= 'un nuevo texto'; { error, se trata de asignar un valor a un puntero que no tiene asignado ningun espacio en memoria }
  new(pc);
  writeln(pc^);
end.