{
  Actividad 2: procesamiento de las autoevaluaciones de CADP
  La cátedra de CADP está analizando los resultados de las autoevaluaciones que realizaron los
  alumnos durante el cuatrimestre. Realizar un programa que lea, para cada alumno, su legajo, su
  condición (I para INGRESANTE, R para RECURSANTE), y la nota obtenida en cada una de las 5
  autoevaluaciones. Si un alumno no realizó alguna autoevaluación en tiempo y forma, se le cargará la
  nota -1. La lectura finaliza al ingresar el legajo -1. Por ejemplo, si la materia tuviera dos alumnos, un
  ingresante y un recursante, la lectura podría ser así:

  Legajo: 19003
  Condición: R
  Notas: 8 10 6 -1 8
  Legajo 21020
  Condición: I
  Notas: 4 0 6 10 -1
  Legajo -1
  (Fin de la lectura)

  Una vez ingresados todos los datos, el programa debe informar:
  - Cantidad de alumnos INGRESANTES en condiciones de rendir el parcial y porcentaje sobre el
    total de alumnos INGRESANTES.
  - Cantidad de alumnos RECURSANTES en condiciones de rendir el parcial y porcentaje sobre el
    total de alumnos RECURSANTES.
  - Cantidad de alumnos que aprobaron todas las autoevaluaciones
  - Cantidad de alumnos cuya nota promedio fue mayor a 6.5 puntos
  - Cantidad de alumnos que obtuvieron cero puntos en al menos una autoevaluación.
  - Código de los dos alumnos con mayor cantidad de autoevaluaciones con nota 10 (diez)
  - Código de los dos alumnos con mayor cantidad de autoevaluaciones con nota 0 (cero)

  Nota: recuerde que, para poder rendir el EXAMEN PARCIAL, el alumno deberá obtener “Presente” en al
  menos el 75% del total de las autoevaluaciones propuestas. Se considera “Presente” la autoevaluación que se
  entrega en tiempo y forma y con al menos el 40% de respuestas correctas.
}
program ejercicio2;
var
  legajo, nota, presentes, ingParcial, recParcial, totalAlums, totalIng, totalRec, aprobaronTodo, cantProm65, totalNotas, cantAlumsCero, maxLeg1_10, maxLeg2_10, maxLeg1_0, maxLeg2_0, max1_10, max2_10, max1_0, max2_0, cantNota10, cantNota0, i: integer; 
  condicion: string;
  sacoCero: boolean;
begin
  max1_10 := -1; max2_10 := -1; max1_0 := -1; max2_0 := -1; cantAlumsCero := 0;
  ingParcial := 0; recParcial := 0; totalAlums := 0; totalIng := 0; totalRec := 0; aprobaronTodo := 0; cantProm65 := 0;
  write('Ingrese legajo: ');readln(legajo);
  while (legajo <> -1) do begin
    sacoCero := false; presentes := 0; totalNotas := 0; cantNota10 := 0; cantNota0 := 0;
    totalAlums := totalAlums + 1;
    write('Ingrese condicion (i: ingresante, r: recursante): ');readln(condicion);
    while (condicion <> 'i') and (condicion <> 'r') do begin
      writeln('Asegurese de ingresar una condicion valida');
      write('Ingrese condicion (i: ingresante, r: recursante): ');readln(condicion);
    end;
    write('Ingrese notas: ');
    for i := 1 to 5 do begin
      readln(nota);
      if (nota <> -1) then begin
        totalNotas := totalNotas + nota;
        if (nota = 0) then begin
          cantNota0 := cantNota0 + 1;
          if not (sacoCero) then begin
            sacoCero := true;
            cantAlumsCero := cantAlumsCero + 1;
          end;
        end;
        if (nota = 10) then
          cantNota10 := cantNota10 + 1;
        if (nota >= 4) then
          presentes := presentes + 1;
      end;
    end;

    if (cantNota10 > max1_10) then begin
      max2_10 := max1_10;
      max1_10 := cantNota10;
      maxLeg2_10 := maxLeg1_10;
      maxLeg1_10 := legajo;
    end
    else begin
      if (cantNota10 > max2_10) then begin
        max2_10 := cantNota10;
        maxLeg2_10 := legajo;
      end;
    end;

    if (cantNota0 > max1_0) then begin
      max2_0 := max1_0;
      max1_0 := cantNota0;
      maxLeg2_0 := maxLeg1_0;
      maxLeg1_0 := legajo;
    end
    else begin
      if (cantNota0 > max2_0) then begin
        max2_0 := cantNota0;
        maxLeg2_0 := legajo;
      end;
    end;

    if (condicion = 'i') then begin
      totalIng := totalIng + 1;
      if (presentes >= 4) then
        ingParcial := ingParcial + 1;
    end
    else
      if (condicion = 'r') then begin
        totalRec := totalRec + 1;
        if (presentes >= 4) then
          recParcial := recParcial + 1;
      end;
    if (presentes = 5) then
      aprobaronTodo := aprobaronTodo + 1;
    if (totalNotas/5 > 6.5) then
      cantProm65 := cantProm65 + 1;
    writeln('');
    write('Ingrese legajo: ');readln(legajo);
  end;
  if (totalAlums <> 0) then begin
    writeln('Cantidad de alumnos ingresantes que pueden rendir el parcial: ', ingParcial);
    writeln('Cantidad de alumnos recursantes que pueden rendir el parcial: ', recParcial);
    if (totalIng <> 0) then
      writeln('Porcentaje de alumnos ingresantes que rinden parcial: ', ingParcial/totalIng*100:0:2,'%')
    else
      writeln('Porcentaje de alumnos ingresantes que rinden parcial: 0%');
    if (totalRec <> 0) then
      writeln('Porcentaje de alumnos recursantes que rinden parcial: ', recParcial/totalRec*100:0:2,'%')
    else
      writeln('Porcentaje de alumnos recursantes que rinden parcial: 0%');
    writeln('Cantidad de alumnos que aprobaron todas las autoevaluaciones: ', aprobaronTodo);
    writeln('Cantidad de alumnos que tubieron nota promedio mayor a 6.5: ', cantProm65);
    writeln('Cantidad de alumnos que obtuvieron cero puntos en al menos una autoevaluacion: ', cantAlumsCero);
    writeln('Alumnos con mayor cantidad de autoevaluaciones con nota 10: ', maxLeg1_10,' y ', maxLeg2_10);
    writeln('Alumnos con mayor cantidad de autoevaluaciones con nota 0: ', maxLeg1_0,' y ', maxLeg2_0);
  end;
end.