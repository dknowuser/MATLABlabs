%������ �.�. 5307
%������ ��������� ����� ������� �� ��������� (-9; 9),
%�������� M > 10 �����, � ������ ���� "���������" �������,
%�������������� ����� ����� ��������� ��������� �� �������� 0,01
%� ��������� ���������� �������� ������� ��� ���� ��������.

%�������� �������:
%1, x, x^2, x^3, ...

function result = MNK()
    %����� �������
    %f = @(x)15*cos(x);
    f = @(x)sin(x);
    
    %������� ����������� ������� �� �����
    hold on;
    px=(-9 + 0.001):0.001:(9 - 0.001);
    plot(px, f(px), 'b');
    
    %�������� �� 10 �����
    M = 10 + round(rand() * 10);
    x = zeros(1, M);
    for i=1:1:M
        x(1, i) = -9 + rand() * 18 + rand();
    end;
    x = sort(x);
    
    %��������� �������� ������� � ���� �����
    y = zeros(1, M);
    for i=1:1:M
        y(1, i) = f(x(1,i));
    end;
    
    %"���������" �������
    for i=1:1:M
        y(1, i) = y(1, i) + 1 + rand() + 0.1*rand() + 0.01*rand();
    end;
    
    %������� �����
    plot(x, y, 'm*');
    
    %����������� �������� (D < 0.01 - ����� �� �����)
    D = 1;
    
    %�������� �������
    Basis = {@(x)x.^1, @(x)x.^2, @(x)x.^3, @(x)x.^4, @(x)x.^5, @(x)x.^6, @(x)x.^7, @(x)x.^8, @(x)x.^9, @(x)x.^10, @(x)x.^11, @(x)x.^12, @(x)x.^13, @(x)x.^14, @(x)x.^15, @(x)x.^16, @(x)x.^17, @(x)x.^18, @(x)x.^19, @(x)x.^20, @(x)x.^21, @(x)x.^22, @(x)x.^23, @(x)x.^24, @(x)x.^25, @(x)x.^26, @(x)x.^27, @(x)x.^28, @(x)x.^29};
    
    %���������� �������� �������
    BasisNumber = 0;
    
    while(D >= 0.01) 
        BasisNumber = BasisNumber + 1;
        
        %���� ������������ ��� ci
        [rows columns] = size(Basis);
        Koeff = zeros(BasisNumber);
        
        for i=1:1:BasisNumber
            for j=i:1:BasisNumber
                if i == 1 && j == 1
                    Koeff(i, j) = 1;
                else
                    Koeff(i, j) = integral(Basis{1, i + j - 2}, 0, 1);
                    Koeff(j, i) = Koeff(i, j);
                end;
            end;
        end;
        
        %������� ������ ����� ������� ���������
        RParts = [];
        
        %���� ������ ������ ��������������
        ix = x;
        while ix(1) < 0% && size(ix) ~= 0
            ix(1) = [];
        end;
        
        %���� ������� ������ ��������������
        [rows columns] = size(ix);
        del = 1;
        while ix(del) <= 1 && del <= columns
            del = del + 1;
        end;
        
        ix(del) = [];
        
        for i=1:1:BasisNumber
            if i == 1
                RParts = trapz(ix, y);
            else
                RParts = [RParts trapz(ix, y.*Basis{1, i - 1}(ix)).*1];
                %RParts = [RParts integral(Mul{1, i - 1}, 0, 1)];
            end;
        end;
        RParts = RParts';
        
        %������ ������� ��������� ������������ ci
        C = Koeff\RParts;
        [rows columns] = size(C);
        
        %���������� ������������ �������� ���������������� ������� �
        %��������
        D = 0;
        
        %������� ���������������� �������
        AppFunc = C(1);
        for j=2:1:rows
            AppFunc = AppFunc + C(j, 1)*Basis{1, j - 1}(px);
        end;
        
        plot(px, AppFunc);
        
        for i=(-9 + 0.001):0.001:(9 - 0.001)
            Temp = f(i) - C(1, 1);
            
            for j=2:1:rows
                Temp = Temp - C(j, 1)*Basis{1, j - 1}(i);
            end;
            
            if abs(Temp) > D
                D = abs(Temp);
            end;
        end;        
    end;
    result = D;
end