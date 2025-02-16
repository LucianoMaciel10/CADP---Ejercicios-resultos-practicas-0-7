{
  Modificar la solución del punto anterior considerando que el programa lea y almacene la información de a
  lo sumo 400 alumnos. La lectura finaliza cuando se ingresa el DNI -1 (que no debe procesarse).
}
program ejercicio8;
const
  dimF = 5; { serian los 400 alumnos aca, pero me olvido y dejo el valor bajo para hacer pruebas xd }
  
type
  alumno = record
    dni: longint;
    num, ano: integer;
    ape, nom: string;
  end;
  vecAlumnos = array[1..dimF] of alumno;

procedure leerAlumno(var a: alumno);
begin
  write('Ingrese dni: ');readln(a.dni);
  if (a.dni <> -1) then begin
    write('Ingrese numero de inscripcion: ');readln(a.num);
    write('Ingrese nombre: ');readln(a.nom);
    write('Ingrese apellido: ');readln(a.ape);
    write('Ingrese ano de nacimiento: ');readln(a.ano);
    writeln();
  end;
end;

procedure cargarVector(var v: vecAlumnos; var dimL: integer);
var
  a: alumno;
begin
  leerAlumno(a);
  while(dimL < dimF) and (a.dni <> -1) do begin
    dimL := dimL + 1;
    v[dimL] := a;
    if (dimL < dimF) then
      leerAlumno(a);
  end;
end;

function porceAlumDNIPar(v: vecAlumnos; dimL: integer): real;
var
  dni: longint;
  i, dig, cant: integer;
begin
  cant := 0;
  for i := 1 to dimL do begin
    dni := v[i].dni;
    while (dni <> 0) do begin
      dig := dni MOD 10;
      if (dig MOD 2 <> 0) then
        break;
      dni := dni DIV 10;
    end;
    if (dni = 0) then
      cant := cant + 1;
  end;
  porceAlumDNIPar := (cant / dimF) * 100;
end;

procedure calcularAlumnosMasGrandes(v: vecAlumnos; dimL: integer; var min1, min2: integer;var minNom1, minNom2, minApe1, minApe2: string);
var
  i: integer;
begin
  for i := 1 to dimL do 
    if (v[i].ano < min1) then begin
      min2 := min1;
      minNom2 := minNom1;
      minApe2 := minApe1;
      min1 := v[i].ano;
      minNom1 := v[i].nom;
      minApe1 := v[i].ape;
    end
    else 
      if (v[i].ano < min2) then begin
        min2 := v[i].ano;
        minNom2 := v[i].nom;
        minApe2 := v[i].ape;
      end;
end;

var
  v: vecAlumnos;
  min1, min2, dimL: integer;
  minNom1, minNom2, minApe1, minApe2: string;
begin
  dimL := 0; min1 := 32767; min2 := 32767;
  cargarVector(v, dimL);
  writeln('El porcentaje de alumnos con DNI compuesto solo por digitos pares es: ', porceAlumDNIPar(v, dimL):0:2,'%');
  calcularAlumnosMasGrandes(v, dimL, min1, min2, minNom1, minNom2, minApe1, minApe2);
  if (minNom1 <> '') then
    writeln('El apellido y nombre de los dos alumnos con mas edad son: ', minNom1 ,' ', minApe1 ,' y ', minNom2 ,' ', minApe2);
end.