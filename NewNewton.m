%Марчук Л.Б. 5307
%Интерполяционный многочлен Ньютона для случайно расположенных точек
function result = NewNewton(x, y)
    [rows, columns] = size(x);
    
    %Интерполяционный многочлен Ньютона
    result = y(1);
    
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
end