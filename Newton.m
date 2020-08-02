%Марчук Л.Б. 5307
%Лабораторная работа №1.2
%Данная программа принимает на вход границы исследуемого интервала
%вектор значений точек, расстояния между которыми одинаковы,
%и по этим данным строит интерполяционный многочлен Ньютона.

function result = Newton(a, b, y)
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
    
    %Интерполяционный многочлен Ньютона
    result = y(1);
    
    Tempy = y;
    Tempc = columns;
    
    for i=1:1:columns - 1
        %Находим на данном шаге конечные разности
        for j=1:1:columns - 1
            y(j) = y(j + 1) - y(j);
        end;
        y(columns) = [];
        
        Mul = 1;
        for j=1:1:i
            Mul = MyConv(Mul, [1 -x(j)]);
        end;
        
        Mul = Mul * y(1);
        Mul = Mul / ((x(2) - x(1))^i);
        Mul = Mul / factorial(j);
        
        result = [0 result];
        result = Mul + result;
        columns = columns - 1;
    end;
    
    %Выводим результат
    hold on;
    
    plot(x,Tempy);
    
    plx=x(1):0.01:x(Tempc);
    ply = polyval(result, plx);
    plot(plx, ply);
    
    hold off;
end