{
  a.  Realizar un módulo que reciba como parámetro el radio de un círculo y retorne su diámetro y su
      perímetro.
  b.  Utilizando el módulo anterior, realizar un programa que analice información de planetas obtenida del
      Telescopio Espacial Kepler. De cada planeta se lee su nombre, su radio (medido en kilómetros) y la distancia
      (medida en años luz) a la Tierra. La lectura finaliza al leer un planeta con radio 0, que no debe procesarse.
      Informar:
        ● Nombre y distancia de los planetas que poseen un diámetro menor o igual que el de la Tierra (12.700
          km) y mayor o igual que el de Marte (6.780 km).
        ● Cantidad de planetas con un perímetro superior al del planeta Júpiter (439.264 km).
}
program ejercicio4;
const
  diameTierra = 12700;
  diameMarte = 6780;
  perimeJupiter = 439264;
  PI = 3.1416;

procedure calcularDiameYperime(radio: real;var diame, perime: real);
begin
  diame := radio*2;
  perime := 2*PI*radio;
end;

procedure leerPlaneta (var radio, distAlaTierra: real;var nom: string);
begin
  write('Ingrese el radio: ');readln(radio);
  if (radio <> 0) then begin
    write('Ingrese el nombre: ');readln(nom);
    write('Ingrese la distancia a la tierra: ');readln(distAlaTierra);
    writeln();
  end;
end;

var
  radio, distAlaTierra, diame, perime: real;
  nom: string;
  cantPerimeSupJupiter: integer;
begin
  cantPerimeSupJupiter := 0;
  leerPlaneta(radio, distAlaTierra, nom);
  while (radio <> 0) do begin
    calcularDiameYperime(radio, diame, perime);
    if (diame <= diameTierra) and (diame >= diameMarte) then
      writeln(nom ,' ', distAlaTierra:0:2 ,' posee un diametro menor o igual que el de la Tierra y mayor o igual que el de Marte');
    if (perime > perimeJupiter) then
      cantPerimeSupJupiter := cantPerimeSupJupiter + 1;
    leerPlaneta(radio, distAlaTierra, nom);
  end;
  writeln('Cantidad de planetas con un perimetro superior al del planeta Jupiter: ', cantPerimeSupJupiter);
end.