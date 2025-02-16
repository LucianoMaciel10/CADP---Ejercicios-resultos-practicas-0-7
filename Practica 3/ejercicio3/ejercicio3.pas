{
  El Ministerio de Educación desea realizar un relevamiento de las 2400 escuelas primarias de la provincia de Bs. As,
  con el objetivo de evaluar si se cumple la proporción de alumnos por docente calculada por la UNESCO para el año
  2015 (1 docente cada 23,435 alumnos). Para ello, se cuenta con información de: CUE (código único de
  establecimiento), nombre del establecimiento, cantidad de docentes, cantidad de alumnos, localidad. Se pide
  implementar un programa que procese la información y determine:
  ● Cantidad de escuelas de La Plata con una relación de alumnos por docente superior a la sugerida por UNESCO.
  ● CUE y nombre de las dos escuelas con mejor relación entre docentes y alumnos.
  El programa debe utilizar:
  a)  Un módulo para la lectura de la información de la escuela.
  b)  Un módulo para determinar la relación docente-alumno (esa relación se obtiene del cociente entre la cantidad
      de alumnos y la cantidad de docentes).
}
program ejercicio3;
const
UNESCO = 23.435;

type
establecimiento = record
  CUE, cantDoce, cantAlum: integer;
  nom, local: string;
end;

function calcularRelacionAlumDoce(cantAlum, cantDoce: integer): real;
begin
  calcularRelacionAlumDoce := cantAlum DIV cantDoce;
end;

procedure leerEstablecimiento(var est: establecimiento);
begin
  write('Ingresar nombre: ');readln(est.nom);
  write('Ingresar localidad: ');readln(est.local);
  write('Ingresar CUE: ');readln(est.CUE);
  write('Ingresar cantidad de alumnos: ');readln(est.cantAlum);
  write('Ingresar cantidad de docentes: ');readln(est.cantDoce);
  writeln();
end;

procedure calcularEscuelasMejorRelacionDoceAlum(est: establecimiento;var relMin1, relMin2: real;var nomMin1, nomMin2: string; var CUEmin1, CUEmin2: integer);
var
  rel: real;
begin
  rel := calcularRelacionAlumDoce(est.cantAlum, est.cantDoce);
  if (rel < relMin1) then begin
    relMin2 := relMin1;
    CUEmin2 := CUEmin1;
    nomMin2 := nomMin1;
    relMin1 := rel;
    CUEmin1 := est.CUE;
    nomMin1 := est.nom;
  end
  else begin
    if (rel < relMin2) then begin
      relMin2 := rel;
      CUEmin2 := est.CUE;
      nomMin2 := est.nom;
    end;
  end;
end;

var
  i, cantLPSupUNESCO, CUEmin1, CUEmin2: integer;
  est: establecimiento;
  nomMin1, nomMin2: string;
  relMin1, relMin2, rel: real;
begin
  cantLPSupUNESCO := 0; relMin1 := 32767; relMin2 := 32767;
  writeln('Lectura de datos de establecimientos');
  for i := 1 to 1 do begin
    leerEstablecimiento(est);
    rel := calcularRelacionAlumDoce(est.cantAlum, est.cantDoce);
    if ((est.local = 'La Plata') or (est.local = 'la plata')) and (rel > UNESCO) then begin
      cantLPSupUNESCO := cantLPSupUNESCO + 1;
    end;
    calcularEscuelasMejorRelacionDoceAlum(est, relMin1, relMin2, nomMin1, nomMin2, CUEmin1, CUEmin2);
  end;
  writeln('Cantidad de escuelas de La Plata con relacion mayor a la de UNESCO (23.435): ', cantLPSupUNESCO);
  writeln('Las dos escuelas con mejor relacion son: ', nomMin1 ,' ', CUEmin1,' y ',nomMin2,' ',CUEmin2);
end.