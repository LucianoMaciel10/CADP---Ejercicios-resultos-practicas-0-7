{
  Realizar un programa que lea información de los candidatos ganadores de las últimas elecciones a intendente de
  la provincia de Buenos Aires. Para cada candidato se lee: localidad, apellido del candidato, cantidad de votos
  obtenidos y cantidad de votantes de la localidad. La lectura finaliza al leer la localidad ‘Zárate’, que debe procesarse.
  Informar:
  ● El intendente que obtuvo la mayor cantidad de votos en la elección.
  ● El intendente que obtuvo el mayor porcentaje de votos de la elección.
}
program ejercicio9;
type
  candidato = record
    local, ape: string;
    cantVotos, cantVotosLocal: integer;
  end;

procedure leerCandidato(var c: candidato);
begin
  write('Ingrese apellido: ');readln(c.ape);
  write('Ingrese localidad: ');readln(c.local);
  write('Ingrese cantidad de votos de la localidad: ');readln(c.cantVotosLocal);
  write('Ingrese cantidad de votos: ');readln(c.cantVotos);
  writeln();
end;

procedure calcularMaxIntendente(cantVotos: integer;ape: string;var max: integer;var apeMax: string);
begin
  if (cantVotos > max) then begin
    max := cantVotos;
    apeMax := ape;
  end;
end;

var
  c: candidato;
  max, totalVotos: integer;
  apeMax: string;
begin
  totalVotos := 0; max := 0;
  writeln('Lectura de datos de candidatos a intendente de BA');
  repeat
    leerCandidato(c);
    totalVotos := totalVotos + c.cantVotos;
    calcularMaxIntendente(c.cantVotos, c.ape, max, apeMax);
  until ((c.local = 'Zarate') or (c.local = 'zarate'));
  if (totalVotos > 0) then
    writeln('El intendente con mas votos es: ', apeMax, ' con ', ((max / totalVotos)* 100):0:2 ,'% de los votos a favor.');
end.