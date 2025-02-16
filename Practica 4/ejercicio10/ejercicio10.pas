{
  Realizar un programa que lea y almacene el salario de los empleados de una empresa de turismo (a lo
  sumo 300 empleados). La carga finaliza cuando se lea el salario 0 (que no debe procesarse) o cuando se
  completa el vector. Una vez finalizada la carga de datos se pide:
  a)  Realizar un módulo que incremente el salario de cada empleado en un 15%. Para ello, implementar un
      módulo que reciba como parámetro un valor real X, el vector de valores reales y su dimensión lógica y
      retorne el mismo vector en el cual cada elemento fue multiplicado por el valor X.
  b)  Realizar un módulo que muestre en pantalla el sueldo promedio de los empleados de la empresa.
}
program ejercicio10;
const
  dimF = 300;
  
type
  numerosV = array[1..dimF] of real;

procedure imprimirVector(v: numerosV; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    write(v[i]:0:2,' ');
  writeln('');
end;
  
procedure cargarVector(var v: numerosV; var dimL: integer);
var
  salario: real;
begin
  write('Ingrese un salario: ');readln(salario);
  while (dimL < dimF) and (salario <> 0) do begin
    dimL := dimL + 1;
    v[dimL] := salario;
    if (dimL < dimF) then
      write('Ingrese un salario: ');readln(salario);
  end;
end;

procedure incrementarSalario(var v: numerosV; dimL:integer; aumento: real);
var
  i: integer;
begin
  for i := 1 to dimL do
    v[i] := v[i] * aumento;
end;

procedure mostrarSueldoPromedio(v: numerosV; dimL: integer);
var
  total: real;
  i: integer;
begin
  total := 0;
  for i := 1 to dimL do
    total := total + v[i];
  writeln('El sueldo promedio de los empleados de la empresa es: ', (total / dimL):0:2);
end;

var
  dimL: integer;
  v: numerosV;
begin
  dimL := 0;
  cargarVector(v, dimL);
  writeln('Antes de incrementar un 15% los sueldos');
  imprimirVector(v, dimL);
  incrementarSalario(v, dimL, 1.15); { aumentar los salario un 15% }
  writeln('Despues de incrementar un 15% los sueldos');
  imprimirVector(v, dimL);
  mostrarSueldoPromedio(v, dimL);
end.