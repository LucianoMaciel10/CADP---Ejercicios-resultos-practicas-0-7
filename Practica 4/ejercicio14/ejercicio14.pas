{
  El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en
  los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que
  participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:

  CÓDIGO        ROL DEL DESARROLLADOR         VALOR/HORA (USD)
    1     Analista Funcional                      35,20
    2     Programador                             27,45
    3     Administrador de bases de datos         31,03
    4     Arquitecto de software                  44,28
    5     Administrador de redes y seguridad      39,87
  
  Nota: los valores/hora se incluyen a modo de ejemplo

  Realizar un programa que procese la información de los desarrolladores que participaron en los 1000
  proyectos de software más activos durante el año 2017. De cada participante se conoce su país de
  residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en
  dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto
  -1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:
  a) El monto total invertido en desarrolladores con residencia en Argentina.
  b) La cantidad total de horas trabajadas por Administradores de bases de datos.
  c) El código del proyecto con menor monto invertido.
  d) La cantidad de Arquitectos de software de cada proyecto.
}
program ejercicio14;
const
  dimF = 5; { 1000 proyectos }
  valorRol1 = 35.20;
  valorRol2 = 27.45;
  valorRol3 = 31.03;
  valorRol4 = 44.28;
  valorRol5 = 39.87;
  
type
  rangoRolEnElproyecto = 1..5;
  desarrollador = record
    pais, nomProyecto: string;
    rol: rangoRolEnElproyecto;
    codProyecto: integer;
    cantHoras: integer;
  end;
  vecDesarrolladores = array[1..dimF] of desarrollador;
  vecInverProyectos = array[1..dimF] of real;
  vecArquitectosSoftware = array[1..dimF] of integer;

procedure leerDesarrollador(var d: desarrollador);
begin
  write('Ingresar codigo de proyecto (1-1000): ');readln(d.codProyecto);
  if (d.codProyecto <> -1) then begin
    write('Ingresar nombre del proyecto: ');readln(d.nomProyecto);
    write('Ingresar rol del desarrollador (1-5): ');readln(d.rol);
    write('Ingresar pais de residencia: ');readln(d.pais);
    write('Ingresar cantidad de horas trabajadas: ');readln(d.cantHoras);
    writeln();
  end;
end;

procedure cargarVector(var v: vecDesarrolladores;var dimL: integer);
var
  d: desarrollador;
begin
  leerDesarrollador(d);
  while (dimL < dimF) and (d.codProyecto <> -1) do begin
    dimL := dimL + 1;
    v[dimL] := d;
    if (dimL < dimF) then
      leerDesarrollador(d);
  end;
end;

function calcularMontoTotalDesaArg(v: vecDesarrolladores; dimL: integer): real;
var
  i: integer;
  total: real;
begin
  total := 0;
  for i := 1 to dimL do begin
    if (v[i].pais = 'Argentina') then
      case v[i].rol of
        1: total := total + (valorRol1 * v[i].cantHoras);
        2: total := total + (valorRol2 * v[i].cantHoras);
        3: total := total + (valorRol3 * v[i].cantHoras);
        4: total := total + (valorRol4 * v[i].cantHoras);
        5: total := total + (valorRol5 * v[i].cantHoras);
      end;
  end;
  calcularMontoTotalDesaArg := total;
end;

function calcularHorasAdminBases(v: vecDesarrolladores; dimL: integer): integer;
var
  i, cantHoras: integer;
begin
  cantHoras := 0;
  for i := 1 to dimL do begin
    if (v[i].rol = 3) then
      cantHoras := cantHoras + v[i].cantHoras;
  end;
  calcularHorasAdminBases := cantHoras;
end;

function calcularProyectoMinMonto(v: vecInverProyectos): integer;
var
  min: real;
  i: integer;
  codMin: integer;
begin
  min := 9999999;
  codMin := -1;
  for i := 1 to dimF do begin
    if (v[i] < min) then begin
      min := v[i];
      codMin := i;
    end;
  end;
  calcularProyectoMinMonto := codMin;
end;

procedure inicializarInversiones(var v: vecInverProyectos);
var
  i: integer;
begin
  for i := 1 to dimF do
    v[i] := 0;
end;

procedure inicializarArcSoftware(var v: vecArquitectosSoftware);
var
  i: integer;
begin
  for i := 1 to dimF do
    v[i] := 0;
end;

procedure calcularInversiones(var vInversiones: vecInverProyectos; v: vecDesarrolladores; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    case v[i].rol of
      1: vInversiones[v[i].codProyecto] :=  vInversiones[v[i].codProyecto] + (v[i].cantHoras * valorRol1);
      2: vInversiones[v[i].codProyecto] :=  vInversiones[v[i].codProyecto] + (v[i].cantHoras * valorRol2);
      3: vInversiones[v[i].codProyecto] :=  vInversiones[v[i].codProyecto] + (v[i].cantHoras * valorRol3);
      4: vInversiones[v[i].codProyecto] :=  vInversiones[v[i].codProyecto] + (v[i].cantHoras * valorRol4);
      5: vInversiones[v[i].codProyecto] :=  vInversiones[v[i].codProyecto] + (v[i].cantHoras * valorRol5);
    end;
end;

procedure calcularCantidadArquitectosSoftware(var vArcSoftware: vecArquitectosSoftware; v: vecDesarrolladores; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    if (v[i].rol = 4) then
      vArcSoftware[v[i].codProyecto] := vArcSoftware[v[i].codProyecto] + 1;
end;

procedure imprimirCantidadArquitectosSoftwareProyectos(v: vecArquitectosSoftware);
var
  i: integer;
begin
  for i := 1 to dimF do
    if (v[i] > 0) then { si es 0 no lo imprime para que no imprima muchas lineas sin sentido }
      writeln('Cantidad de arquitectos de software del proyecto ', i ,': ', v[i]);
end;

procedure imprimirInversiones(v: vecInverProyectos);
var
  i: integer;
begin
  for i := 1 to dimF do
    write(v[i]:0:2,' ');
end;

var
  v: vecDesarrolladores;
  dimL: integer;
  vInversiones: vecInverProyectos;
  vArcSoftware: vecArquitectosSoftware;
begin
  dimL := 0;
  inicializarInversiones(vInversiones);
  inicializarArcSoftware(vArcSoftware);
  cargarVector(v, dimL);
  calcularInversiones(vInversiones, v, dimL);
  calcularCantidadArquitectosSoftware(vArcSoftware, v, dimL);
  writeln('Monto total invertido en desarrolladores con residencia en Argentina: ', calcularMontoTotalDesaArg(v, dimL):0:2);
  writeln('Cantidad de horas trabajadas por administradores de bases de datos: ', calcularHorasAdminBases(v, dimL));
  writeln('Proyecto con menor monto invertido: ', calcularProyectoMinMonto(vInversiones));
  imprimirCantidadArquitectosSoftwareProyectos(vArcSoftware);
  writeln('Inversiones de cada proyecto');
  imprimirInversiones(vInversiones);
end.