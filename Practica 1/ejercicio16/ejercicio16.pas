{
  Realizar un programa que lea desde teclado información de autos de carrera. Para cada uno de los
  autos se lee el nombre del piloto y el tiempo total que le tomó finalizar la carrera. En la carrera
  participaron 100 autos. Informar en pantalla:
  - Los nombres de los dos pilotos que finalizaron en los dos primeros puestos.
  - Los nombres de los dos pilotos que finalizaron en los dos últimos puestos.
}
program ejercicio16;
var
  i: integer; 
  nom, nomMax1, nomMax2, nomMin1, nomMin2: string; 
  tiempo, max1, max2, min1, min2: real;
begin
  max1 := -1; max2 := -1; min1 := 32767; min2 := 32767;
  for i := 1 to 100 do begin
    write('Ingrese nombre de piloto: ');readln(nom);
    write('Ingrese tiempo: ');readln(tiempo);
    writeln('');

    if (tiempo > max1) then begin
      max2 := max1;
      nomMax2 := nomMax1;
      max1 := tiempo;
      nomMax1 := nom;
    end
    else begin
      if (tiempo > max2) then begin
        max2 := tiempo;
        nomMax2 := nom;
      end;
    end;

    if (tiempo < min1) then begin
      min2 := min1;
      nomMin2 := nomMin1;
      min1 := tiempo;
      nomMin1 := nom;
    end
    else begin
      if (tiempo < min2) then begin
        min2 := tiempo;
        nomMin2 := nom;
      end;
    end;
  end;
  writeln('Los pilotos que llegaron primero son: ', nomMin1, ' y ', nomMin2);
  writeln('Los pilotos que llegaron ultimos son: ', nomMax1, ' y ', nomMax2);
end.