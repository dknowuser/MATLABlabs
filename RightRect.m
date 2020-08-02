%Марчук Л.Б. 5307
%Данная программа вычисляет интеграл заданной функции
%методом правых прямоугольников и вычисляет скорость сходимости интеграла.
%В качестве входных параметров программа принимает отрезок интегрирования,
%начальное число точек разбиения и конечное число точек разбиения.
%h1 < h2
%RightRect(0, 5, 100, 1000)

function result = RightRect(a, b, h1, h2)
    %Задаём функцию
    f = @(x)cos(x);
    freal = integral(f, a, b);
    
    hs = [];
    alph = [];
    for i=h1:1:h2        
        %Находим длину отрезка деления
        c = (b - a) / i;        
        hs = [hs c];
        
        %Находим интеграл
        result = 0;
        for j = a:c:b
            result = result + f(j + c)*c;
        end;
        
        %Вычисляем альфа        
        alpha = -(log(abs(result - freal)));
        alpha = alpha / log(i);% - 0.5;
        alph = [alph alpha];
    end;
    hold on;
    plot(hs, alph, 'k');
    hold off;
end