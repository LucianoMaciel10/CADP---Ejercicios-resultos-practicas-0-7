{
  a.  Completar el programa principal para que lea información de alumnos (código, nombre, promedio) e informe
      la cantidad de alumnos leídos. La lectura finaliza cuando ingresa un alumno con código 0, que no debe
      procesarse. Nota: utilizar el módulo leer.
  b.  Modificar al programa anterior para que, al finalizar la lectura de todos los alumnos, se informe también el
      nombre del alumno con mejor promedio.
}
program Registros;
type
str20 = string[20];
alumno = record
  codigo : integer;
  nombre : str20;
  promedio : real;
end;

procedure leer(var alu : alumno);
begin
  write('Ingrese el codigo del alumno: ');readln(alu.codigo);
  if (alu.codigo <> 0) then begin
    write('Ingrese el nombre del alumno: '); readln(alu.nombre);
    write('Ingrese el promedio del alumno: '); readln(alu.promedio);
    writeln();
  end;
end;

{ declaración de variables del programa principal }
var
  a : alumno;
  cantAlums: integer;
  minProm: real;
  minNom: string;
{ cuerpo del programa principal }
begin
  cantAlums := 0; minProm := -1;
  leer(a);
  while (a.codigo <> 0) do begin
    cantAlums := cantAlums + 1;
    if (a.promedio > minProm) then begin
      minProm := a.promedio;
      minNom := a.nombre;
    end;
    leer(a);
  end;
  writeln('Cantidad de alumnos leidos: ', cantAlums);
  writeln('Alumno con mejor promedio: ', minNom);
end.