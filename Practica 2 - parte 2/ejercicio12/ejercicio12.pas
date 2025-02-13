{
  a.  Realizar un módulo que calcule el rendimiento económico de una plantación de soja. El módulo debe
      recibir la cantidad de hectáreas (ha) sembradas, el tipo de zona de siembra (1: zona muy fértil, 2: zona estándar, 3: zona árida) y el precio en U$S de la tonelada de soja; y devolver el rendimiento económico esperado de dicha plantación.
  
  Para calcular el rendimiento económico esperado debe considerar el siguiente rendimiento por tipo de zona:

  Tipo de zona     Rendimiento por ha
      1           6 toneladas por ha
      2           2,6 toneladas por ha
      3           1,4 toneladas por ha

  b.  ARBA desea procesar información obtenida de imágenes satelitales de campos sembrados con soja en la
      provincia de Buenos Aires. De cada campo se lee: localidad, cantidad de hectáreas sembradas y el tipo de zona (1, 2 ó 3). La lectura finaliza al leer un campo de 900 ha en la localidad ‘Saladillo’, que debe procesarse. El precio de la soja es de U$S320 por tn. Informar:
      ● La cantidad de campos de la localidad Tres de Febrero con rendimiento estimado superior a U$S 10.000.
      ● La localidad del campo con mayor rendimiento económico esperado.
      ● La localidad del campo con menor rendimiento económico esperado.
      ● El rendimiento económico promedio.
}
program ejercicio12;
const 
  precioSoja = 320;

function calcularRendEcon(cantHa, tipo: integer; precio: real): real;
begin
  case tipo of
    1: calcularRendEcon := cantHa * precio * 6;
    2: calcularRendEcon := cantHa * precio * 2.6;
    3: calcularRendEcon := cantHa * precio * 1.4;
  else
		writeln('Tipo de siembra no valida');
  end;
end;

procedure leerCampo (var local: string; var tipo, cantHa: integer);
begin
  write('Ingrese localidad: ');readln(local);
  write('Ingrese cantidad de hectareas sembradas: ');readln(cantHa);
  write('Ingrese tipo de zona: ');readln(tipo);
  writeln();
end;

procedure calcularCantTresFebreroREsup10(local: string; cantHa, tipo: integer; RE: real; var cantTresFebreroREsup10: integer);
begin
  if (local = 'Tres de Febrero') or (local = 'tres de febrero') or (local = 'Tres de febrero') and (RE > 10000) then
    cantTresFebreroREsup10 := cantTresFebreroREsup10 + 1;
end;

procedure localMaxRE(local: string; RE: real;var localMax: string;var maxRE: real);
begin
  if (RE > maxRe) then begin
    maxRe := RE;
    localMax := local;
  end;  
end;

procedure localMinRE(local: string; RE: real;var localMin: string;var minRE: real);
begin
  if (RE < minRe) then begin
    minRe := RE;
    localMin := local;
  end;  
end;

var
  local, localMax, localMin: string;
  maxRE, minRE, totalRE, RE: real;
  cantHa, tipo, cantTresFebreroREsup10, cantCampos: integer;
begin
  cantTresFebreroREsup10 := 0; maxRE := -1; minRE := 32767; totalRE := 0; cantCampos := 0;
  repeat
    leerCampo(local, tipo, cantHa);
    cantCampos := cantCampos + 1;
    RE := calcularRendEcon(cantHa, tipo, precioSoja);
    totalRE := totalRE + RE;
    calcularCantTresFebreroREsup10(local, cantHa, tipo, RE, cantTresFebreroREsup10);
    localMaxRE(local, RE, localMax, maxRE);
    localMinRE(local, RE, localMin, minRE);
  until ((local = 'saladillo') or (local = 'Saladillo') and (cantHa = 900));
  writeln('La cantidad de campos de la localidad Tres de Febrero con rendimiento estimado superior a U$S 10.000 es: ', cantTresFebreroREsup10);
  writeln('La localidad del campo con mayor rendimiento económico esperado es: ', localMax);
  writeln('La localidad del campo con menor rendimiento económico esperado es: ', localMin);
  writeln('El rendimiento económico promedio es: ', totalRE/cantCampos:0:2);
end.