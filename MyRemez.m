%������ �.�. 5307

%������ ��������� � �������� ������� ����������
%��������� ������������ ����� (n + 2)-� �����
%a <= t0 < t1 < ... < tn+1 <= b � ��������
%� ������� ��������� ���������� ����������� 
%�� ��������� ������.
%MyRemez([-8 -5 0 2 3], 0.1)
function result = MyRemez(points, Epsilon)
    %����� ����������� �������
    f = @(x)sin(x);
    
    d = 0;
    D = 1;
    [rows, columns] = size(points);
    P = [];
    
    %�������� ���� ���� |d| ~= D
    while abs(D - d) >= Epsilon
        %������� �����
        clf;
        
        %������� ����������� �������
        hold on;
        px=points(1):0.001:points(columns);
        plot(px, f(px), 'b');

        %������� ��������� �����
        plot(points, f(points), 'm*');
        
        %���� ���������������� ���������
        %���������� ������� ������������� ��� aj (������� �����������)
        A = Wandermond(points);
        [rows acol] = size(A);
        for i=1:1:acol/2
            Temp = A(:,i);
            A(:,i) = A(:,acol - i + 1);
            A(:,acol - i + 1) = Temp;
        end;
        
        %���������� ������-������� ������ �����
        B = f(points)';
        
        A = [A B];
        for i=1:1:columns
            A(i, acol + 1) = (-1).^i;
        end;
        
        %������ ������� �������� ���������
        P = A\B;
        
        %������ ���������������� ���������
        P = P';
        d = abs(P(columns + 1));
        P(columns + 1) = [];
        
        %������� ��������� ���������
        plot(px, polyval(P, px));
        
        %���� xmax �����, ��� D = |f(ksi) - P(ksi)| = max
        delta = @(x) -abs(f(x) - polyval(P, x));
        xmax = points(1);
        D = -delta(points(1));
        
        for i=points(1):((points(columns) - points(1))/1000):points(columns)
            [dx, dy] = fminbnd(delta, i, i + ((points(columns) - points(1))/10000));
            
            dy = -dy;
            if dy > D
                D = dy;
                xmax = dx;
            end;
        end;
        
        %������
        if (xmax > points(1)) && (xmax < points(columns))
            i = 1;
            while xmax > points(i)
                i = i + 1;
            end;
            
            if delta(xmax)*delta(points(i)) >= 0
                points(i) = xmax;
            else
                points(i - 1) = xmax;
            end;
        else
            if xmax < points(1)
                Temp = points(1);
                points(1) = xmax;
                if delta(xmax)*delta(Temp) < 0
                    for j=1:1:columns - 1
                        points(j + 1) = points(j);
                    end;
                end;
            else
                Temp = points(columns);
                points(columns) = xmax;
                if delta(xmax)*delta(Temp) < 0
                    for j=1:1:columns - 1
                        points(j) = points(j + 1);
                    end;
                end;
            end;
        end;        
        %����� ��� ���������
        pause(1);
    end;
end