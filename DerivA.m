%������ �.�. 5307
%2�

%������ ��������� ������� ����������� �������� �������
%�� ������� f'(x0) = (f(x0 + h) - f(x0)) / h
%� �������� ����� x0 (�� ���� - �������, x0 � h, d - �������� h).
%����� ������������� ��������
%DerivA([1 0 1000], -100, 0.1, 40)
function result = DerivA(func, x0, h, d)
    [rows, columns] = size(x0);
    if (rows~=1) || (columns~=1)
        error('������! x0 ������ ���� ������ ������.');
    end;
        
    [rows, columns] = size(h);
    if (rows~=1) || (columns~=1)
        error('������! h ������ ���� ������ ������.');
    end;
    
    [rows, columns] = size(d);
    if (rows~=1) || (columns~=1)
        error('������! d ������ ���� ������ ������.');
    end;
    
    [rows, columns] = size(func);    
    if rows ~= 1
        error('������! ������ ������� �������� ������ ���� ��������.');
    end;
    
    hold on
    hs = [];
    Step = h/d;
    alph = [];
    %� ����� �������� �� �������� h � �������� h
    for i=d:-1:1
        hs = [hs Step*i];
        result = (polyval(func, x0 + Step*i) - polyval(func, x0)) / (Step*i);

        fcalc = result;
        freal = polyval(MyDiff(func), x0);

        alpha = log(abs(fcalc - freal));
        alpha = alpha / log(Step*i);
        alph = [alph alpha];
    end;
    plot(hs, alph, 'm');
    hold off;
    
    %������� �������� �����������
    figure;
    hold on;
    px=(x0 - 100):0.01:(x0 + 100);
    py = polyval(MyDiff(func), px);
    plot(px, py, 'b');
    
    %������� ��������� �����������
    py = (polyval(func, px + Step) - polyval(func, px)) / Step;
    plot(px, py, 'r');
end