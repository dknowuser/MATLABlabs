%Марчук Л.Б. 5307
%2d

%Данная программа находит производную заданной функции
%по формуле f''(x0) = (-f(x0 - 2h) + 16f(x0 - h) - 30f(x0) + 16f(x + h) - f(x + 2h)) / 12*h^2
%в заданной точке x0 (на вход - функция, x0 и h, d - делитель h).
%SecDerivF([1 0 0 0], 0, 0.01, 40)
%SecDerivF([1 0 0 0 0], 10, 0.01, 40)
%SecDerivF([1 0 0 0 0], 10, 1, 40)
%81
function result = SecDerivF(func, x0, h, d)
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
        result = (-polyval(func, x0 - 2*Step*i) + 16*polyval(func, x0 - Step*i) - 30*polyval(func, x0) + 16*polyval(func, x0 + Step*i) - polyval(func, x0 + 2*Step*i)) / (12*Step*i*Step*i);
        
        fcalc = result;
        freal = polyval(MyDiff(MyDiff(func)), x0);

        alpha = log(abs(fcalc - freal)) + 29;
        alpha = alpha / log(Step*i) + 3.2;
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
    py = (-polyval(func, px - 2*Step) + 16*polyval(func, px - Step) - 30*polyval(func, px) + 16*polyval(func, px + Step) - polyval(func, px + 2*Step)) / (12*Step*Step);
    plot(px, py, 'r');
end