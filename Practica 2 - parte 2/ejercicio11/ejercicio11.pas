{
  Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón
  A%B*, donde:
  - A es una secuencia de caracteres en la que no existe el carácter ‘$’.
  - B es una secuencia con la misma cantidad de caracteres que aparecen en A y en la que aparece a lo sumo
  3 veces el carácter ‘@’.
  - Los caracteres % y * seguro existen
  Nota: en caso de no cumplir, informar que parte del patrón no se cumplió.
}
program ejercicio11;

procedure mensajeSiCumpleElPatron(cumpleA, cumpleB: boolean);
begin
  if (cumpleA) and (cumpleB) then
    writeln('La secuencia cumple el patron')
  else 
    if not (cumpleA) and not (cumpleB) then
      writeln('La secuencia no cumple el patron A y B')
    else 
      if not (cumpleA) then
        writeln('La secuencia no cumple el patron A')
      else
        if not (cumpleB) then
          writeln('La secuencia no cumple el patron B');
end;

procedure cumpleOnoCumple(fin: char; var cumple: boolean; var cantCaractsA, cantCaractsB: integer);
var
  cantArroba: integer;
  carac: char;
begin
  cantArroba := 0;
  write('Ingrese un caracter: ');readln(carac);
  if (carac = fin) then
    cumple := false;
  while (carac <> fin) do begin
    if (fin = '%') then begin
      if (carac = '$') and (cumple) then
        cumple := false;
      cantCaractsA := cantCaractsA + 1;
    end
    else begin
      if (fin = '*') then begin
        if (carac = '@') then
          cantArroba := cantArroba + 1;
        cantCaractsB := cantCaractsB + 1;
      end
    end;
    write('Ingrese un caracter: ');readln(carac);
  end;
  if (fin = '*') then begin
    if (cantArroba >= 3) and (cantCaractsA = cantCaractsB) then
      cumple := true;
  end;
end;

var
  cumpleA, cumpleB: boolean;
  cantCaractsA, cantCaractsB: integer;
begin
  cumpleA := true; cumpleB := false; cantCaractsA := 0; cantCaractsB := 0;
  cumpleOnoCumple('%', cumpleA, cantCaractsA, cantCaractsB);
  writeln('---- Finalizo la parte A ----');
  cumpleOnoCumple('*', cumpleB, cantCaractsA, cantCaractsB);
  writeln('---- Finalizo la parte B ----');
  mensajeSiCumpleElPatron(cumpleA, cumpleB);
end.