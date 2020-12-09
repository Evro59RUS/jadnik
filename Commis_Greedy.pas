
Program Commis_Greedy;

Const 
  RR:  Array [0..4,0..4] of Integer =
             ((0, 3, 4, 2, 7),
              (3, 0, 4, 6, 3),
              (4, 4, 0, 5, 8),
              (2, 6, 5, 0, 6),
              (7, 3, 8, 6, 0)); 
Var
    OutputFileS:  String;
             fr:  Text;      
      N, MinDist: Integer;
             way:  array [0..5] of Integer;
     last, lf, d, 
    m, MinD, nmbK: Integer;
       
//=========================================================
begin  
  OutputFileS := GetDir + '\OutputFileS'; // Имя файла результатов
{$I-}
//     Открытие файла OutputFileS для записи 
  Assign (fr, OutputFileS);
  Rewrite (fr);             

  N := 5;   // число городов
  MinD := 100;
     // Выбор города JJ в качестве стартового
  for var  JJ := 0  to  N - 1  do 
    begin
      Writeln (fr, '=================');
      Writeln (fr, 'Вариант JJ = ', JJ);
      Writeln (fr, '=================');
      
      for var i := 0  to  N - 1  do  way[i]:= i;           // все города
    
      m := way[JJ];  way[JJ] := way[0];  way[0] := m; // JJ-тый город ставим первым
      
      Write (fr,' Начальный порядок городов в JJ-м варианте:    ');
      for  var j := 0  to  N - 2 do  Write(fr, way[j], ', ');  Writeln(fr, way[N -1]);
      Writeln(fr);      
    
      last := JJ;       // last - последний посещённый город
      lf := 1;
      d := 0;           // текущее расстояние
    
      While (lf < N)  do
        begin
          MinDist := RR[last,way[lf]];
          for  var k := lf + 1  to  4  do           // ищем ближайший к last город
            begin
              if  RR[last,way[k]] < MinDist  then
                begin
                  MinDist := RR[last,way[k]]; nmbK := k;
                end; 
            end; // k     
          Writeln (fr, '  MinDist = ', MinDist);  
          m := way[nmbK];  way[nmbK] := way[lf];  way[lf] := m;  //ближайший переносим в начало
         
          Write (fr,' Текущий порядок городов в JJ-м варианте:    ');
          for  var j := 0  to  N - 2 do  Write(fr, way[j], ', ');  Writeln(fr, way[N -1]);
          Writeln(fr);      
      
          d := d + MinDist;   // суммируем общую длину пути
          last := way[lf];     
          lf := lf + 1;// берём "первый" как ближайший
                       
          Writeln (fr,'  d = ', d, '  lf = ', lf, '  last = ', last);
       end;// While (lf < N)
      
      last := way[lf];
      d := d + RR[last,way[4]];
      
      Writeln (fr, '  last = ', last, '   RR = ', RR[last,way[4]], '  d = ', d);
     
      Writeln (fr);
      Writeln (fr, 'Общая длина пути варианта JJ = ', JJ, ':  d = ', d);
      Writeln (fr);
      if  d < MinD  then  MinD := d;
     end; // JJ
     
  Writeln (fr, 'Лучшая длина пути dMin = ', MinD);
  //=========================================================  
  Close(fr);
{$I+}      
  
end. // Commis_Greedy
    

