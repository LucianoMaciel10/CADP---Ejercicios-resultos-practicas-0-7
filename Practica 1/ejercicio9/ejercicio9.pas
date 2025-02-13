{
  Realizar un programa que lea un carácter, que puede ser “+” (suma) o “-” (resta); si se ingresa otro
  carácter, debe informar un error y finalizar. Una vez leído el carácter de suma o resta, deberá leerse
  una secuencia de números enteros que finaliza con 0. El programa deberá aplicar la operación leída
  con la secuencia de números, e imprimir el resultado final.
  Por ejemplo:
  ○ Si se lee el carácter “-” y la secuencia 4 3 5 -6 0 , deberá imprimir: 2 (4 – 3 – 5 - (-6) )
  ○ Si se lee el carácter “+” y la secuencia -10 5 6 -1 0, deberá imprimir 0 ( -10 + 5 + 6 + (-1) )
}
program ejercicio;
var
  signo: char; num, total: integer;
begin
  write('Ingrese un signo ("-", "+"): ');readln(signo);
  if (signo <> '+') AND (signo <> '-') then begin
    writeln('Error ingresando signo');
    halt;
  end;
  
  write('Ingrese un numero: ');readln(num);
  total := num;
  while(num <> 0) do begin
    write('Ingrese un numero: ');readln(num);
    if (signo = '+') then
      total := total + num
    else
      total := total - num;
  end;
  writeln('Total: ', total);
end.