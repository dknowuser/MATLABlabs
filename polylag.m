%Марчук Л.Б. 5307
%Лабораторная работа №1.2
%Данная программа принимает на вход границы исследуемого интервала
%вектор значений точек, расстояния между которыми одинаковы,
%и по этим данным строит интерполяционный многочлен Лагранжа.
function result = polylag(a, b, y)
    
    [rows, columns] = size(a);

    if (rows~=1) || (columns~=1)
        error('Ошибка! Границы исследуемого интервала должны быть заданы числами.');
    end;
    
    [rows, columns] = size(b);
    
    if (rows~=1) || (columns~=1)
        error('Ошибка! Границы исследуемого интервала должны быть заданы числами.');
    end;

    [rows, columns] = size(y);
    
    if rows ~= 1
        error('Ошибка! Последний входной параметр должен быть вектором.');
    end;
    
    if b < a
        error('Ошибка! Абсцисса правой границы интервала должна быть больше');
    end;
    
    %Делим область определения точками
    %Определяем цену деления
    C = (b - a) / (columns - 1);
    x = zeros(rows, columns);
    Column = 1;
    
    %Находим абсциссы
    for i=a:C:b
        x(Column) = i;
        Column = Column + 1;
    end;
    
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
    
    %Выводим результат
    hold on;   
    plot(x,y);
    
    plx=x(1):0.01:x(columns);
    ply = polyval(result, plx);
    plot(plx, ply);
end