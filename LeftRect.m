%������ �.�. 5307
%������ ��������� ��������� �������� �������� �������
%������� ����� ��������������� � ��������� �������� ���������� ���������.
%� �������� ������� ���������� ��������� ��������� ������� ��������������,
%��������� ����� ����� ��������� � �������� ����� ����� ���������
%� ��������, � ������� ���������� ����������� �����.
%h1 < h2
%[integr time] = LeftRect(0, 5, 100, 1000, 0);
%[integr time] = LeftRect(1, inf, 100, 1000, 0.0001);

function [result, meastime] = LeftRect(a, b, h1, h2, Eps)
    %����� �������
    f = @(x)cos(x);
    freal = integral(f, a, b);
    
    %��� �������������� ���������
    %f = @(x)1/(x*x + 1);
    %freal = pi/4;
    
    %�������� ����������� ������� ���������
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
    
    hs = [];
    alph = [];
    
    %�������� ������ ������������ �������
    StartTime = cputime();
    
    for i=h1:1:h2        
        %������� ����� ������� �������
        c = (b - a) / i;        
        hs = [hs c];
        
        %������� ��������
        result = 0;
        for j = a:c:b
            result = result + f(j)*c;
        end;
        
        %��������� �����        
        alpha = -(log(abs(result - freal)) - 1.2);
        alpha = alpha / log(i);% - 0.0048;
        alph = [alph alpha];
    end;
    meastime = cputime() - StartTime;
    
    hold on;
    plot(hs, alph, 'r');
    hold off;
end