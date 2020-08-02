%������ �.�. 5307
%������ ��������� ��������� �������� �������� �������
%������� ������ ��������������� � ��������� �������� ���������� ���������.
%� �������� ������� ���������� ��������� ��������� ������� ��������������,
%��������� ����� ����� ��������� � �������� ����� ����� ���������.
%h1 < h2
%RightRect(0, 5, 100, 1000)

function result = RightRect(a, b, h1, h2)
    %����� �������
    f = @(x)cos(x);
    freal = integral(f, a, b);
    
    hs = [];
    alph = [];
    for i=h1:1:h2        
        %������� ����� ������� �������
        c = (b - a) / i;        
        hs = [hs c];
        
        %������� ��������
        result = 0;
        for j = a:c:b
            result = result + f(j + c)*c;
        end;
        
        %��������� �����        
        alpha = -(log(abs(result - freal)));
        alpha = alpha / log(i);% - 0.5;
        alph = [alph alpha];
    end;
    hold on;
    plot(hs, alph, 'k');
    hold off;
end