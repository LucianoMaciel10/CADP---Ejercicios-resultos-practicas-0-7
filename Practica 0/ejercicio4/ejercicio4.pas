{
  Implemente un programa que lea el diámetro D de un círculo e imprima:
  a.  El radio (R) del círculo (la mitad del diámetro)
  b.  El área del círculo. Para calcular el área de un círculo debe utilizar la fórmula PI x R^2
  c.  El perímetro del círculo. Para calcular el perímetro del círculo debe utilizar la fórmula
      D*PI (o también PI*R*2)
}
program ejercicio4;
const 
  PI = 3.14;
var
  diam: real;
begin
  read(diam);
  writeln('Radio: ', diam/2:0:2);
  writeln('Area: ', (PI*(diam/2*diam/2)):0:2);
  writeln('Perimetro: ', diam*PI:0:2);
end.