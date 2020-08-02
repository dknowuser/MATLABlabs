%Марчук Л.Б. 5307
%2b

%Данная программа находит производную заданной функции
%по формуле f'(x0) = (f(x1) - f(x-1)) / (2*h)
%в заданной точке x0 (на вход - функция, x0 и h, d - делитель h).
%DerivB([1 0 0 0], -10, 0.1, 40) 
function result = DerivB(func, x0, h, d)
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
        result = (polyval(func, x0 + Step*i) - polyval(func, x0 - Step*i)) / (2*Step*i);

        fcalc = result;
        freal = polyval(MyDiff(func), x0);

        alpha = log(abs(fcalc - freal));
        alpha = alpha / log(Step*i) - 1;
        alph = [alph alpha];
    end;
    plot(hs, alph, 'm');
    hold off;
    
    %Выводим реальную производную
    figure;
    hold on;
    px=(x0 - 100):0.01:(x0 + 100);
    py = polyval(MyDiff(func), px);
    plot(px, py, 'b');
    
    %Выводим найденную производную
    py = (polyval(func, px + Step) - polyval(func, px - Step)) / (2*Step);
    plot(px, py, 'r');
end