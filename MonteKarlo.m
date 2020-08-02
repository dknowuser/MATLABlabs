%Марчук Л.Б. 5307
%Данная программа вычисляет интеграл заданной функции
%методом Монте-Карло. В качестве входных параметров программа принимает
%отрезок интегрирования, количество случайных величин
%и точность, с которой обрезаются бесконечные концы.
%[integr time] = MonteKarlo(1,inf,25600000,0.0001);
%N = 25600000
function [result, meastime] = MonteKarlo(a, b, N, Eps)
    %Задаём функцию
    f = @(x)1/(x*x + 1);
    
    %Обрезаем бесконечные границы интервала
    if a == inf
        a = 0;
        while abs(f(a)) >= Eps
            a = a - 0.0001;
        end;
    end;
    
    if b == inf
        b = 0;
        while abs(f(b)) >= Eps
            b = b + 0.0001;
        end;
    end;
        
    result = 0;
    
    %Начинаем отсчёт затраченного времени
    StartTime = cputime();
    
    %Выбираем N точек на отрезке интегрирования
    for i=1:1:N
        temp = rand()*(b - a) + a;
        
        %Суммируем значения функции в этих точках
        result = result + f(temp);
    end;
    result = result*(b - a)/N;
    meastime = cputime() - StartTime;
end