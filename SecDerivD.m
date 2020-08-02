%Марчук Л.Б. 5307
%2d

%Данная программа находит производную заданной функции
%по формуле f''(x0) = (f(x-1) + f(x1) - 2f(x0))/h^2 старая
%новая f''(x0) = (f(x0) - 2*f(x1) + f(x2))/h^2
%в заданной точке x0 (на вход - функция, x0 и h, d - делитель h).
%SecDerivD([1 0 0 0 0], 10, 1, 4000)
function result = SecDerivD(func, x0, h, d)
    [rows, columns] = size(x0);
    if (rows~=1) || (columns~=1)
        error('Ошибка! x0 должно быть задано числом.');
    end;
        
    [rows, columns] = size(h);
    if (rows~=1) || (columns~=1)
        error('Ошибка! h должно быть задано числом.');
    end;
    
    [rows, columns] = size(d);
    if (rows~=1) || (columns~=1)
        error('Ошибка! d должно быть задано числом.');
    end;
    
    [rows, columns] = size(func);    
    if rows ~= 1
        error('Ошибка! Первый входной параметр должен быть вектором.');
    end;
    
    hold on
    hs = [];
    Step = h/d;
    alph = [];
    %В цикле проходим от большего h к меньшему h
    for i=d:-1:1
        hs = [hs Step*i];
        result = (polyval(func, x0) - 2*polyval(func, x0 + Step*i) + polyval(func, x0 + 2*Step*i)) / (Step*i*Step*i);

        fcalc = result;
        freal = polyval(MyDiff(MyDiff(func)), x0);

        alpha = log(abs(fcalc - freal));% - 0.75;
        alpha = alpha / log(Step*i);% - 1;
        alph = [alph alpha];
    end;
    plot(hs, alph, 'm');
    hold off;
    
    %Выводим реальную производную
    figure;
    hold on;
    px=(x0 - 100):0.01:(x0 + 100);
    py = polyval(MyDiff(MyDiff(func)), px);
    plot(px, py, 'b');
    
    %Выводим найденную производную
    py = (polyval(func, px) - 2*polyval(func, px + Step) + polyval(func, px + 2*Step)) / (Step*Step);
    plot(px, py, 'r');
end