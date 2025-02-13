{
  a.  Realice un módulo que lea de teclado números enteros hasta que llegue un valor negativo. Al finalizar la
      lectura el módulo debe imprimir en pantalla cuál fue el número par más alto.
  b.  Implemente un programa que invoque al módulo del inciso a.
}
program ejercicio6;

procedure valorMaxAlto;
var 
  num, max : integer;
begin
  max := -1;
  write('Ingrese un numero: ');readln(num);
  while (num >= 0) do begin
    if (num > max) then
      max := num;
    write('Ingrese un numero: ');readln(num);
  end;
  writeln(max);
end;

begin
  valorMaxAlto;
end.