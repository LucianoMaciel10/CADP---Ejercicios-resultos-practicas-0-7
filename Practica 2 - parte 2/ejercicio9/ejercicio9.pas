{
  11. Realizar un programa modularizado que lea información de alumnos de una facultad. Para cada alumno se
  lee: número de inscripción, apellido y nombre. La lectura finaliza cuando se ingresa el alumno con número de
  inscripción 1200, que debe procesarse. Se pide calcular e informar:
  ● Apellido de los dos alumnos con número de inscripción más chico.
  ● Nombre de los dos alumnos con número de inscripción más grande.
  ● Porcentaje de alumnos con nro de inscripción par.
}
program ejercicio9;

procedure leerAlumno(var num: integer;var ape, nom: string);
begin
  write('Ingrese numero de alumno: ');readln(num);
  write('Ingrese nombre de alumno: ');readln(nom);
  write('Ingrese apellido de alumno: ');readln(ape);
  writeln();
end;

procedure apellidosNumerosMasBajos(num: integer; ape: string;var numMin1, numMin2: integer;var apeMin1, apeMin2: string);
begin
  if (num < numMin1) then begin
    numMin2 := numMin1;
    apeMin2 := apeMin1;
    numMin1 := num;
    apeMin1 := ape;
  end
  else begin
    if (num < numMin2) then begin
      numMin2 := num;
      apeMin2 := ape;
    end;
  end;
end;

procedure nombresNumerosMasAltos(num: integer; nom: string;var numMax1, numMax2: integer;var nomMax1, nomMax2: string);
begin
  if (num > numMax1) then begin
    numMax2 := numMax1;
    nomMax2 := nomMax1;
    numMax1 := num;
    nomMax1 := nom;
  end
  else begin
    if (num > numMax2) then begin
      numMax2 := num;
      nomMax2 := nom;
    end;
  end;
end;

var
  num, numMin1, numMin2, numMax1, numMax2, totalAlums, totalNumPar: integer;
  ape, nom, apeMin1, apeMin2, nomMax1, nomMax2: string;
begin
  numMin1 := 32767; numMin2 := 32767; totalAlums := 0; numMax1 := -1; numMax2 := -1; totalNumPar := 0;
  repeat
    leerAlumno(num, ape, nom);
    apellidosNumerosMasBajos(num, ape, numMin1, numMin2, apeMin1, apeMin2);
    nombresNumerosMasAltos(num, nom, numMax1, numMax2, nomMax1, nomMax2);
    if (num MOD 2 = 0) then
      totalNumPar := totalNumPar + 1;
    totalAlums := totalAlums + 1;
  until (num = 1200);
  writeln('Apellido de los dos alumnos con numero de inscripcion mas chico: ', apeMin1 ,' y ', apeMin2);
  writeln('Nombre de los dos alumnos con numero de inscripcion mas grande: ', nomMax1 ,' y ', nomMax2);
  writeln('Porcentaje de alumnos con numero par: ', (totalNumPar/totalAlums)*100:0:2 ,'%');
end.