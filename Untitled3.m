%[x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira1.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira2.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira4.wav');
%[x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira5.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira6.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira7.wav');

[x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira8.wav');
x=x(:,1);
data = x;
% ������ 'heart_sound_data' ���� ������� ���� ����� ��� �������

% ������ �� �� �������� ����� �� ������ ������ ������
if ~isvector(data)
    error('�������� ��� �� ���� ����� ������ ������ (������)');
end

% ����� ��� ������ (��� 'sym4' �� 'db4')
waveletName = 'sym4';  % ���� ������ ��� 'db4' �� �� ��� ��� �� �������
numLevels = 4;  % ����� ��� ��������� �� ������� �������

% ����� ������� ������� (DWT) ��� �������
[C, L] = wavedec(data, numLevels, waveletName);

% ������� �������� ��� ����� ���������
A = appcoef(C, L, waveletName, numLevels);  % ������ ����� ������ (Approximation)
D = cell(1, numLevels);  % ������ �������� ��� �� �����

for i = 1:numLevels
    D{i} = detcoef(C, L, i);  % ������� �������� ��� ������� i
end

% ��� �������� �������
figure;
subplot(2, 1, 1);
plot(A);
title('������ ����� ������ (Approximation)');
xlabel('�����');
ylabel('�����');

% ��� �������� ��� ������� 1 (����)
subplot(2, 1, 2);
plot(D{1});
title('�������� ��� ������� 1 (Details)');
xlabel('�����');
ylabel('�����');

% ���� ����� ������� (�����ɡ ������� ��������)
mean_val = mean(data);  % ���� �������
variance_val = var(data);  % ���� �������
energy_val = sum(data.^2) / length(data);  % ���� ������

% ���� ������ �������� �������� (������ ������� ���������)
energy_approx = sum(A.^2);  % ���� ������ ������� ������
energy_details = sum(D{1}.^2);  % ���� �������� ��� ������� 1

% ��� ����� ��������
disp(['�������: ', num2str(mean_val)]);
disp(['�������: ', num2str(variance_val)]);
disp(['������: ', num2str(energy_val)]);
disp(['���� ������ ������� ������: ', num2str(energy_approx)]);
disp(['���� �������� ��� ������� 1: ', num2str(energy_details)]);

% ����� ������� ����� ������� �������� (���� �������)
% mean_threshold = 0.01;  % ���� �������
% variance_threshold = 0.005;  % ���� �������
% energy_threshold = 1e-10;  % ���� ������
lowfreq=5000;
% ������� ����� ��� �������
% if mean_val > mean_threshold && variance_val > variance_threshold && energy_val > energy_threshold
%     disp('������� ������');
% else
%     disp('������� ����');
% end
if energy_approx>lowfreq;
        disp('������� ������');
 else
  disp('������� ��� ������')
end
% ����� ���� ������� �� ��������� DWT
reconstructed_data = waverec(C, L, waveletName);

% ��� ������� ������� ������� ������ ��������
figure;
subplot(3, 1, 1);
plot(data);
title('������� �������');
xlabel('�����');
ylabel('�����');

subplot(3, 1, 2);
plot(reconstructed_data);
title('������� ������ ������');
xlabel('�����');
ylabel('�����');
sptool
     
% ������� ���� ����
b = [1 2 1];  % ������� �����
a = [1  -1.6981209373758073  0.96984710693870957]; % ������� ������

% ����� ������ ��� ����� x
y = filter(b, a, x);

% ��� ������� ��������

subplot(3, 1, 3);
plot(y);
title('Filtered Signal');
