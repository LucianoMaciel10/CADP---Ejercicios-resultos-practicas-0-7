{
  Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón
  A$B#, donde:
  - A es una secuencia de sólo letras vocales
  - B es una secuencia de sólo caracteres alfabéticos sin letras vocales
  - los caracteres $ y # seguro existen
  Nota: en caso de no cumplir, informar que parte del patrón no se cumplió.
}
program ejercicio10;

function esVocal(letra: char): boolean;
begin
  esVocal := (letra = 'a') or (letra = 'e') or (letra = 'i') or (letra = 'o') or (letra = 'u') or (letra = 'A') or (letra = 'E') or (letra = 'I') or (letra = 'O') or (letra = 'U');
end;

function esCaracterEspecial(letra: char): boolean;
begin
  esCaracterEspecial := (letra = '.') or (letra = ',') or (letra = '+') or (letra = '*') or
                        (letra = '´') or (letra = '$') or (letra = '%') or (letra = '¿') or
                        (letra = '¡') or (letra = '¨') or (letra = '"') or (letra = '-') or
                        (letra = '_') or (letra = '!') or (letra = '?') or (letra = ')') or
                        (letra = '(') or (letra = '&') or (letra = '/') or (letra = '=') or
                        (letra = '<') or (letra = '>') or (letra = '|') or (letra = '°') or
                        (letra = ';') or (letra = ':') or (letra = '[') or (letra = ']') or
                        (letra = '{') or (letra = '}') or (letra = '''') or (letra = '\') or
                        (letra = '`') or (letra = '^') or (letra = '~');
end;


procedure mensajeSiCumpleElPatron(cumpleA, cumpleB: boolean);
begin
  if (cumpleA) and (cumpleB) then
    writeln('La entrada cumple el patron')
  else begin
    if not (cumpleA) and not (cumpleB) then
      writeln('La entrada no cumple el patron A y B')
    else begin
      if not (cumpleA) then
        writeln('La entrada no cumple el patron A')
      else
        if not (cumpleB) then
          writeln('La entrada no cumple el patron B');
    end;
  end;
end;

procedure cumpleOnoCumple(fin: char; var cumple: boolean);
var
  letra: char;
begin
  write('Ingrese una letra: ');readln(letra);
  if (letra = fin) then
    cumple := false;
  while (letra <> fin) do begin
    if (fin = '$') then begin
      if not (esVocal(letra)) and (cumple) then
        cumple := false;
    end
    else begin
      if (fin = '#') then begin
        if (esVocal(letra)) or (esCaracterEspecial(letra)) and (cumple) then
          cumple := false;
      end
    end;
    write('Ingrese una letra: ');readln(letra);
  end;
end;

var
  cumpleA, cumpleB: boolean;
begin
  cumpleA := true; cumpleB := true;
  cumpleOnoCumple('$', cumpleA);
  writeln('---- Finalizo la parte A ----');
  cumpleOnoCumple('#', cumpleB);
  writeln('---- Finalizo la parte B ----');
  mensajeSiCumpleElPatron(cumpleA, cumpleB);
end.