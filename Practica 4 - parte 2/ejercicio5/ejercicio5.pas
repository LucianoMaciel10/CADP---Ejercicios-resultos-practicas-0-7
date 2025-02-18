{
  La empresa Amazon Web Services (AWS) dispone de la información de sus 500 clientes monotributistas más
  grandes del país. De cada cliente conoce la fecha de firma del contrato con AWS, la categoría del
  monotributo (entre la A y la F), el código de la ciudad donde se encuentran las oficinales (entre 1 y 2400) y
  el monto mensual acordado en el contrato. La información se ingresa ordenada por fecha de firma de
  contrato (los más antiguos primero, los más recientes últimos).
  Realizar un programa que lea y almacene la información de los clientes en una estructura de tipo vector.
  Una vez almacenados los datos, procesar dicha estructura para obtener:
  a. Cantidad de contratos por cada mes y cada año, y año en que se firmó la mayor cantidad de contratos
  b. Cantidad de clientes para cada categoría de monotributo
  c. Código de las 10 ciudades con mayor cantidad de clientes
  d. Cantidad de clientes que superan mensualmente el monto promedio entre todos los clientes.
}
program ejercicio5;
const
  maxClientes = 4; { 500 }
  
type
  tipoFecha = record
    dia, mes, ano: integer;
  end;
  codigoCiudad = 1..2400;
  categorias = 'A'..'F';
  cliente = record
    fecha: tipoFecha;
    monto: integer;
    cate: categorias;
    codCiudad: codigoCiudad;
  end;
  vecClientes = array[1..maxClientes] of cliente;
  vecCategorias = array[categorias] of integer;
  vecCiudades = array[codigoCiudad] of integer;
  vecMaxCiudades = array[1..10] of integer;

procedure leerFecha(var dia, mes, ano: integer);
begin
  write('Ingrese el dia: ');readln(dia);
  write('Ingrese el mes: ');readln(mes);
  write('Ingrese el ano: ');readln(ano);
end;

procedure leerCliente(var c: cliente);
begin
  leerFecha(c.fecha.dia, c.fecha.mes, c.fecha.ano);
  write('Ingrese categoria del monotributo: ');readln(c.cate);
  write('Ingrese codigo de la ciudad donde se encuentran las oficinales (1-2400): ');readln(c.codCiudad);
  // write('Ingrese monto mensual acordado: ');readln(c.monto);
  writeln();
end;

procedure cargarClientes(var v: vecClientes);
var
  c: cliente;
  i: integer;
begin
  for i := 1 to maxClientes do begin
    leerCliente(c);
    v[i] := c;
  end;
end;

procedure calcularContratosPorMesYporAno(v: vecClientes);
  
  procedure calcularMaxAnoContratos(totalAno, anoAct: integer;var max, maxAno: integer);
  begin
    if (totalAno > max) then begin
      max := totalAno;
      maxAno := anoAct;
    end;
  end;

var
  mesAct, anoAct, cantMes, totalAno, i, max, maxAno: integer;
begin
  i := 1; max := -1;
  while (i <= maxClientes) do begin
    anoAct := v[i].fecha.ano; totalAno := 0;
    writeln('Ano ', anoAct ,':');
    while (i <= maxClientes) and (v[i].fecha.ano = anoAct) do begin
      totalAno := totalAno + 1;
      mesAct := v[i].fecha.mes; cantMes := 0;
      while (i <= maxClientes) and (v[i].fecha.ano = anoAct) and (v[i].fecha.mes = mesAct) do begin
        cantMes := cantMes + 1;
        i := i + 1;
      end;
      writeln('Mes ', mesAct ,': ', cantMes);

    end;
    calcularMaxAnoContratos(totalAno, anoAct, max, maxAno);
    writeln();
  end;
  writeln('El ano con mas contratos firmados es: ', maxAno);
end;

procedure inicializarVectorCategorias(var v: vecCategorias);
var
  i: categorias;
begin
  for i := 'A' to 'F' do 
    v[i] := 0;
end;

procedure calcularCantPorCategorias(v: vecClientes; var vCateg: vecCategorias);
var
  j: categorias;
  i: integer;
begin
  for i := 1 to maxClientes do
    vCateg[v[i].cate] := vCateg[v[i].cate] + 1;
  for j := 'A' to 'F' do
    writeln('La categoria ', j ,' tiene: ', vCateg[j] ,' clientes');
end;

procedure inicializarVectorCuidades(var v: vecCiudades);
var
  i: codigoCiudad;
begin
  for i := 1 to 2400 do
    v[i] := 0;
end;

procedure calcularMaximos10Ciudades(v: vecClientes; var vCiud: vecCiudades; var vMCiud: vecMaxCiudades);
var
  i: codigoCiudad;
  j, max, maxCod, ciudadesRegistradas: integer;
begin
  ciudadesRegistradas := 0;
  for i := 1 to maxClientes do
    vCiud[v[i].codCiudad] := vCiud[v[i].codCiudad] + 1;
  
  for j := 1 to 10 do begin
    max := -1; maxCod := -1;
    for i := 1 to 2400 do 
      if (vCiud[i] > max) then begin
        max := vCiud[i];
        maxCod := i;
      end;

    if (maxCod = -1) then
      break;
    
    vMCiud[j] := maxCod;
    vCiud[maxCod] := -1;
    ciudadesRegistradas := ciudadesRegistradas + 1;
  end;
  
  writeln('Top 10 ciudades con mas clientes');
  for j := 1 to ciudadesRegistradas do
    if (vMCiud[j] <> -1) then
      writeln('Posicion ', j, ': Ciudad ', vMCiud[j]);
end;

procedure inicializarVectorMaxCuidades(var v: vecMaxCiudades);
var
  i : integer;
begin
  for i := 1 to 10 do
    v[i] := -1;
end;

var
  v: vecClientes;
  vCateg: vecCategorias;
  vCiud: vecCiudades;
  vMCiud: vecMaxCiudades;
begin
  cargarClientes(v);
  calcularContratosPorMesYporAno(v);
  inicializarVectorCategorias(vCateg);
  writeln();
  calcularCantPorCategorias(v, vCateg);
  inicializarVectorCuidades(vCiud);
  writeln();
  inicializarVectorMaxCuidades(vMCiud);
  calcularMaximos10Ciudades(v, vCiud, vMCiud);
end.