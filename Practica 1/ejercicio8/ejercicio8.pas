{
  Realizar un programa que lea tres caracteres, e informe si los tres eran letras vocales o si al menos
  uno de ellos no lo era. Por ejemplo, si se leen los caracteres “a e o” deberá informar “Los tres son
  vocales”, y si se leen los caracteres “z a g” deberá informar “al menos un carácter no era vocal”.
}
program ejercicio8;
var
  c1, c2, c3: char;
begin
  writeln('Ingrese 3 caracteres:');
  readln(c1);
  readln(c2);
  readln(c3);
  if (c1 <> 'a') and (c1 <> 'e') and (c1 <> 'i') and (c1 <> 'o') and (c1 <> 'u') then
    writeln('Al menos un caracter no era vocal')
  else
  if (c2 <> 'a') and (c2 <> 'e') and (c2 <> 'i') and (c2 <> 'o') and (c2 <> 'u') then
    writeln('Al menos un caracter no era vocal')
  else
  if (c3 <> 'a') and (c3 <> 'e') and (c3 <> 'i') and (c3 <> 'o') and (c3 <> 'u') then
    writeln('Al menos un caracter no era vocal')
  else
    writeln('Los tres son vocales');
end.