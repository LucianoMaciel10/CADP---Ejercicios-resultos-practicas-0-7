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
  new(pc);
  pc^:= 'un nuevo nombre';
  writeln(sizeof(pc^), ' bytes'); { 51 bytes }
  writeln(pc^);  { un nuevo nombre }
  dispose(pc);
  pc^:= 'otro nuevo nombre'; { error, se intenta asignar un valor a un puntero que ya no apunta a un espacio en memoria }
end.