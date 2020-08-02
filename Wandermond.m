%Марчук Л.Б. 5307
%Лабораторная №1.1
%Ломается при n = 15

function result=Wandermond(x) 
    [m, n] = size(x);
    
    if m ~= 1
        error('Ошибка! Входной параметр должен быть вектором.');
    end;
    
    %Строим матрицу Вандермонда
    result = ones(n, 1);
    
    for i=1:1:(n - 1)
        Temp = x';
        Temp = Temp.^i;
        result = [result, Temp];
    end;
end