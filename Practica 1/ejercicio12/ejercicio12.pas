{
  Realizar un programa que lea desde teclado la información de alumnos ingresantes a la carrera
  Analista en TIC. De cada alumno se lee nombre y nota obtenida en el módulo EPA (la nota es un
  número entre 1 y 10). La lectura finaliza cuando se lee el nombre “Zidane Zinedine“, que debe
  procesarse. Al finalizar la lectura informar:
  - La cantidad de alumnos aprobados (nota 8 o mayor) y
  - la cantidad de alumnos que obtuvieron un 7 como nota
}
program ejercicio12;
var
  nom: string; nota, aprobados, alumSiete: integer;
begin
  aprobados := 0;
  alumSiete := 0;
  repeat
    write('Ingrese nombre: ');readln(nom);
    write('Ingrese nota: ');readln(nota);
    while(nota > 10) and (nota < 0) do begin
      writeln('No se permite nota mayor a 10 o menor a 0, intente de nuevo.');
      write('Ingrese nota: ');readln(nota);
    end;
    if (nota >= 8) then
      aprobados := aprobados + 1;
    if (nota = 7) then
      alumSiete := alumSiete + 1;
  until (nom = 'Zidane Zinedine');
  writeln('Cantidad de alumnos aprobados: ', aprobados);
  writeln('Cantidad de alumnos con nota igual a 7: ', alumSiete);
end.