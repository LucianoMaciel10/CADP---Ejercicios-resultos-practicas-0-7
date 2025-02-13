{
  
}
program anidamientos;

function analizarLetra(letra: char): boolean;
begin
  if (letra >= 'a') and (letra <= 'z') then
    analizarLetra := true
  else
    if (letra >= 'A') and (letra <= 'Z') then
      analizarletra := false
    else begin
      writeln('Error: El caracter ingresado no es una letra.');
      halt;  { Finaliza el programa si el caracter no es una letra }
    end;
end; { fin de la funcion analizarLetra }

procedure leer;
var 
  letra: char;
begin
  readln(letra);
  if (analizarLetra(letra)) then
    writeln('Se trata de una minúscula')
  else
    writeln('Se trata de una mayúscula');
end; { fin del procedure leer}

var
  ok : boolean;
  letra : char;
begin { programa principal }
  leer;

  write('Ingrese otra letra: ');
  readln(letra);
  ok := analizarLetra(letra);
  if ok then
    writeln('Gracias, vuelva prontosss');
end.