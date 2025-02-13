{
  El siguiente programa intenta resolver un enunciado. Sin embargo, el código posee 5 errores. Indicar en
  qué línea se encuentra cada error y en qué consiste el error.
  Enunciado: Realice un programa que lea datos de 130 programadores Java de una empresa. De cada
  programador se lee el número de legajo y el salario actual. El programa debe imprimir el total del dinero
  destinado por mes al pago de salarios, y el salario del empleado mayor legajo.
}
program programadores;

procedure leerDatos(var legajo: integer; salario : real); { 2. salario no es una parametro de referencia - 3. estan mal ordenados los parametros }
begin
  writeln('Ingrese el nro de legajo y el salario');
  read(legajo);
  read(salario);
end;

procedure actualizarMaximo(nuevoLegajo:integer; nuevoSalario:real; var maxLegajo:integer);
var
  maxSalario : real;
begin
  if (nuevoLegajo > maxLegajo) then begin 
    maxLegajo:= nuevoLegajo;
    maxSalario := nuevoSalario { 5. maxSalario es modificado pero no se devuelve por parametro }
  end;
end;

var
  legajo, maxLegajo, i : integer;
  salario, maxSalario : real;
begin
  sumaSalarios := 0; { 1. sumaSalarios no esta definido }
  for i := 1 to 130 do begin
    leerDatos(salario, legajo); 
    actualizarMaximo(legajo, salario, maxLegajo); { 4. no se le pasa el maxSalario }
    sumaSalarios := sumaSalarios + salario;
  end;
  writeln('En todo el mes se gastan ', sumaSalarios, ' pesos');
  writeln('El salario del empleado más nuevo es ',maxSalario);
end.