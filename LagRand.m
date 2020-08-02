%Полином Лагранжа для случайно расположенных точек
function result = LagRand(x, y)
    [rows, columns] = size(x);
    
    %Интерполяционный многочлен Лагранжа
    result = zeros;
    
    %Общая сумма
    for i=1:1:columns
        Temp = y(i);
        
        %Считаем знаменатель
        Mul = 1;
        for j=1:1:columns
            if i == j
                continue;
            end;
                
            Mul = Mul * (x(i) - x(j));
        end; 
        Temp = Temp / Mul;
        
        %Считаем числитель
        Mul = 1;
        for j=1:1:columns
            if i == j
                continue;
            end;
            
            Mul = conv(Mul, [1 -x(j)]);
        end;
        
        Temp = Temp * Mul;        
        result = result + Temp;
    end;
end