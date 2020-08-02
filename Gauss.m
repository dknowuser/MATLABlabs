%������ �.�. 5307
%������ ��������� ��������� �������� �������� �������
%� ������� ����������� ������� ������.
%� �������� ������� ���������� ��������� ���������
%��������� � �������� ����� ������� ��������������,
%��������� ����� ����� ��������� � �������� ����� ����� ���������
%� ��������, � ������� ���������� ����������� �����.
%h1 < h2
%[integr time] = Gauss(1, inf, 100, 1000, 0.0001);
function [result, meastime] = Gauss(a, b, h1, h2, Eps)
    %����� �������
    f = @(x)1/(x*x + 1);
    freal = pi/4;
    
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
        
        %��������� ��������
        result = 0;
        for j=a:c:(b - c)
            x1 = j + c/2*(1 - sqrt(3/5));
            x2 = j + c/2;
            x3 = j + c/2*(1 + sqrt(3/5));
            result = result + c/18*(5*f(x1) + 8*f(x2) + 5*f(x3));
        end;
        
        %��������� �����        
        alpha = -(log(abs(result - freal)));
        alpha = alpha / log(i);% + 3;
        alph = [alph alpha];
    end;
    meastime = cputime() - StartTime;
    
    hold on;
    plot(hs, alph, 'm');
    hold off;
end