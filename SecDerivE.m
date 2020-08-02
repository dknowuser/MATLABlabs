%������ �.�. 5307
%2e

%������ ��������� ������� ����������� �������� �������
%��� ������ �������� ����������������� ����������������
%������� �������.
%��� ��������� �� ���� ����������� �������, x0 � h, d - �������� h.
%SecDerivE([1 0], 0, 100, 80)
function result = SecDerivE(func, x0, h, d)
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
    
    hs = [];
    Diff = [];
    alph = [];
    
    %�������� �� ����� ����� �� d
    for n = 2:1:d    
        %��������� �������� ��������������� �������
        %���������� ���� �������
        C = h / n;
        x = zeros(1, n);
        y = zeros(1, n);

        %������� �������� � ��������
        for i=1:1:n
            x(i) = x0 + C*(i - 1);
            y(i) = polyval(func, x(i));
        end;

        for i=1:1:n - 1
            y(i) = y(i + 1) - y(i);
        end;
        y(n) = [];
        n = n - 1;

        %������� �������� �������� (��������� � �������� �������� ������� �������)
        Differences = [];
        factorialn = 2;
        hMul = C * C;

        while n > 1
            for i=1:1:n - 1
                y(i) = y(i + 1) - y(i);
            end;
            y(n) = [];
            n = n - 1;

            %����� �� ���������
            Value = y(1) / factorial(factorialn);

            %����� �� �������� ������� ����� ��������� �������
            Value = Value / hMul;

            hMul = hMul * C;
            factorialn = factorialn + 1;

            Differences = [Differences Value];
        end;

        [rows, columns] = size(Differences);

        %������� �������� ��� ��������� �������� ��������� � ����� ������
        %�������������� ��
        pRes = 0;
        pBase = [1 -x(1)];

        for i=1:1:columns
            %�������� ������� ��� �������� �������� ���������� �������
            pMul = [1 -x(i + 1)];
            pBase = conv(pBase, pMul);

            %������ ��� ��������������
            pDiff = MyDiff(MyDiff(pBase));

            %��������� �� ��������������� �����������
            pDiff = pDiff * Differences(i);

            %���������� � ��������������� ��������
            if i > 1
                pRes = [0 pRes];
            end;
            pRes = pRes + pDiff;
        end;
        
        %������� �������� ����������� � ������ �����
        result = polyval(pRes, x0);
        
        hs = [hs C];
        Diff = [Diff result];
        
        fcalc = result;
        freal = polyval(MyDiff(MyDiff(func)), x0);
        
        alpha = log(abs(fcalc - freal));
        alpha = alpha / log(C) + 20;
        alph = [alph alpha];
    end;
    
    %������� ����������� ����� �� h
    hold on;
    plot(hs, alph, 'm');
    hold off;
    
    %������� �������� �����������
    figure;
    hold on;
    px=x0:0.0001:(x0 + h);
    py = polyval(MyDiff(MyDiff(func)), px);
    plot(px, py, 'b');
    
    %������� ��������� �����������
    py = polyval(pRes, px);
    plot(px, py, 'r');
end