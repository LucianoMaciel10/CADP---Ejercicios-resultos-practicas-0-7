{
  Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de
  escritorio.
}
program ejercicio1;
type
  cadena = string[50];
  puntero_cadena = ^cadena;
var
  pc: puntero_cadena;
begin
  writeln(sizeof(pc), ' bytes'); { 4 bytes }
  new(pc);
  writeln(sizeof(pc), ' bytes'); { 4 bytes }
  pc^:= 'un nuevo nombre';
  writeln(sizeof(pc), ' bytes'); { 4 bytes }
  writeln(sizeof(pc^), ' bytes'); { 51 bytes }
  pc^:= 'otro nuevo nombre distinto al anterior';
  writeln(sizeof(pc^), ' bytes'); { 51 bytes }
end.