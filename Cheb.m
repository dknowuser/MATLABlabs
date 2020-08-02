%������ �.�. 5307
%������������ �1.4
%������ ��������� ��������� �� ���� ������� ������������ �������,
%����� ������ ���������� ��������(����������� ������� ������� � ����)       
%�  ���� �� ���� ������� ����� ��������, ������ �� ��������� ������ 
%������� �������� � � �������� ��������� ����� �� ����������� ������� 
%���������� ����������� � ������������ ������������ ������������.
function result = Cheb(a, b, steps)
        [rows, columns] = size(a);
        if (rows~=1) || (columns~=1)
            error('������! ������� ������������ ������� ������ ���� ������ �������.');
        end;
        
        [rows, columns] = size(b);
        if (rows~=1) || (columns~=1)
            error('������! ������� ������������ ������� ������ ���� ������ �������.');
        end;
        
        [rows, columns] = size(steps);
        if (rows~=1) || (columns~=1)
            error('������! ��������� �������� ������ ���� ������.');
        end;
        
        if a > b
            error('��������� ����� ������� ������ ���� ������ ��������.');
        end;
        
        %����� �������
        poly = [5 -4 3 -2 1];
        
        %������� � �� �����
        hold on;
        plx=a:0.01:b;
        ply = polyval(poly, plx);
        plot(plx, ply, 'b');
        
        %���������� ��������� ��������
        Tprev = [0 1];
        
        %������� ��������� ��������
        Tcur = [1 0];
        
        %���� ��������� �������� �� ��������� ����
        for i=1:1:steps - 1
            Temp = Tcur;
            Tcur = 2 * [1 0];
            Tcur = conv(Tcur, Temp);

            %����������� ������ ������� Tprev
            [rows, columns] = size(Tcur);
            Diff = columns;
            [rows, columns] = size(Tprev);
            Diff = Diff - columns;
            for j=1:1:Diff
            	Tprev = [0 Tprev];
            end;

            Tcur = Tcur - Tprev;
            Tprev = Temp;
        end;
        
        %���� ����� ���������� ���������� �� �������� �������
        R = roots(Tcur);
        if steps > 1
            R = R';

            %���������� ����� �� �������� ��������
            %������ ������� ������ ��������
            CR = max(R) - min(R);

            %����� ������������ �������
            CInt = b - a;

            %����������� ���������������
            Mul = CInt/CR;

            R = R - min(R);

            R = a + R*Mul;
        end;
        
        %��������� �������� ������� ������� � ������ ������ �������� 
        hold on;
        V = polyval(poly, R);
        plot(R, V, 'ko');
        
        %������ �� ��� ������� ��������
        La = LagRand(R, V);
        
        %��������� ���
        La = (round(La * 1000000))/1000000;
        
        %������� ������� ��������
        plx=a:0.01:b;
        ply = polyval(La, plx);
        plot(plx, ply, 'r');
        
        %�������� �����, ������� ����� ������� ��������
        R = sort(R);
        Sample = abs(R(2) - R(1))*rand() + min(R(2), R(1));
        %Sample = 0.6;
        
        %������� �����������
        oy = polyval(poly, Sample);
        ly = polyval(La, Sample);
        mDiff = abs(oy - ly);
        
        %������� ������������� �����������      
        for i=1:1:steps + 1
            %���� �����������            
             poly = MyDiff(poly);            
        end;
        
        plx=a:0.01:b;
        ply = polyval(poly, plx);
        tMax = max(ply);
        tDiff = tMax*(b - a)^(steps + 1)/(2^(2*steps + 1)*factorial(steps + 1));
        
        if mDiff <= tDiff
            disp('����������� �������� ����������� � ����� ');
            disp(Sample);
            disp(' ������ ��� ����� ��������������.');
        else
            disp('����������� �������� ����������� � ����� ');
            disp(Sample);
            disp(' ������ ��������������.');
        end;
        
        disp('������������� �����������:');
        disp(tDiff);
        disp('������������ �����������:');
        disp(mDiff);
end