%[x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira1.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira2.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira4.wav');
%[x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira5.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira6.wav');
% [x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira7.wav');

[x fs]=audioread('C:\Users\ASUS\Desktop\amira\amira8.wav');
x=x(:,1);
data = x;
% ÇÓÊÈÏá 'heart_sound_data' ÈÇÓã ÇáãÊÛíÑ ÇáĞí íÍÊæí Úáì ÇáÅÔÇÑÉ

% ÇáÊÃßÏ ãä Ãä ÇáÈíÇäÇÊ ÚÈÇÑÉ Úä ãÕİæİÉ ÃÍÇÏíÉ ÇáÈõÚÏ
if ~isvector(data)
    error('ÇáÈíÇäÇÊ íÌÈ Ãä Êßæä ÅÔÇÑÉ ÃÍÇÏíÉ ÇáÈõÚÏ (ãÕİæİÉ)');
end

% ÊÍÏíÏ äæÚ ÇáãæÌÉ (ãËá 'sym4' Ãæ 'db4')
waveletName = 'sym4';  % íãßä ÊÛííÑå Åáì 'db4' Ãæ Ãí äæÚ ÂÎÑ ãä ÇáãæÌÇÊ
numLevels = 4;  % ÊÍÏíÏ ÚÏÏ ÇáãÓÊæíÇÊ İí ÇáÊÍæíá ÇáãæíÌí

% ÊØÈíŞ ÇáÊÍæíá ÇáãæíÌí (DWT) Úáì ÇáÅÔÇÑÉ
[C, L] = wavedec(data, numLevels, waveletName);

% ÇÓÊÎÑÇÌ ÇáãßæäÇÊ Úáì ãÎÊáİ ÇáãÓÊæíÇÊ
A = appcoef(C, L, waveletName, numLevels);  % Çáãßæä ãäÎİÖ ÇáÊÑÏÏ (Approximation)
D = cell(1, numLevels);  % áÊÎÒíä ÇáÊİÇÕíá ÚäÏ ßá ãÓÊæì

for i = 1:numLevels
    D{i} = detcoef(C, L, i);  % ÇÓÊÎÑÇÌ ÇáÊİÇÕíá ÚäÏ ÇáãÓÊæì i
end

% ÚÑÖ ÇáãßæäÇÊ ÇáãæÌíÉ
figure;
subplot(2, 1, 1);
plot(A);
title('Çáãßæä ãäÎİÖ ÇáÊÑÏÏ (Approximation)');
xlabel('ÇáÒãä');
ylabel('ÇáÓÚÉ');

% ÚÑÖ ÇáÊİÇÕíá ÚäÏ ÇáãÓÊæì 1 (ãËÇá)
subplot(2, 1, 2);
plot(D{1});
title('ÇáÊİÇÕíá ÚäÏ ÇáãÓÊæì 1 (Details)');
xlabel('ÇáÒãä');
ylabel('ÇáÓÚÉ');

% ÍÓÇÈ ÎÕÇÆÕ ÇáÅÔÇÑÉ (ÇáØÇŞÉ¡ ÇáÊÈÇíä¡ æÇáãÊæÓØ)
mean_val = mean(data);  % ÍÓÇÈ ÇáãÊæÓØ
variance_val = var(data);  % ÍÓÇÈ ÇáÊÈÇíä
energy_val = sum(data.^2) / length(data);  % ÍÓÇÈ ÇáØÇŞÉ

% ÍÓÇÈ ÇáØÇŞÉ ááãßæäÇÊ ÇáãæíÌíÉ (ãßæäÇÊ ÇáÊŞÑíÈ æÇáÊİÇÕíá)
energy_approx = sum(A.^2);  % ØÇŞÉ Çáãßæä ÇáãäÎİÖ ÇáÊÑÏÏ
energy_details = sum(D{1}.^2);  % ØÇŞÉ ÇáÊİÇÕíá ÚäÏ ÇáãÓÊæì 1

% ÚÑÖ ÇáŞíã ÇáãÍÓæÈÉ
disp(['ÇáãÊæÓØ: ', num2str(mean_val)]);
disp(['ÇáÊÈÇíä: ', num2str(variance_val)]);
disp(['ÇáØÇŞÉ: ', num2str(energy_val)]);
disp(['ØÇŞÉ Çáãßæä ÇáãäÎİÖ ÇáÊÑÏÏ: ', num2str(energy_approx)]);
disp(['ØÇŞÉ ÇáÊİÇÕíá ÚäÏ ÇáãÓÊæì 1: ', num2str(energy_details)]);

% ÊÍÏíÏ ÇáÚÊÈÇÊ æİŞğÇ ááäÊÇÆÌ ÇáãÑÌÚíÉ (íãßä ÊÚÏíáåÇ)
% mean_threshold = 0.01;  % ÚÊÈÉ ÇáãÊæÓØ
% variance_threshold = 0.005;  % ÚÊÈÉ ÇáÊÈÇíä
% energy_threshold = 1e-10;  % ÚÊÈÉ ÇáØÇŞÉ
lowfreq=5000;
% ÇáÊÕäíİ ÈäÇÁğ Úáì ÇáÚÊÈÇÊ
% if mean_val > mean_threshold && variance_val > variance_threshold && energy_val > energy_threshold
%     disp('ÇáÅÔÇÑÉ ØÈíÚíÉ');
% else
%     disp('ÇáÅÔÇÑÉ ÔÇĞÉ');
% end
if energy_approx>lowfreq;
        disp('ÇáÅÔÇÑÉ ØÈíÚíÉ');
 else
  disp('ÇáÇÔÇÑÉ ÛíÑ ØÈíÚíÉ')
end
% ÅÚÇÏÉ ÈäÇÁ ÇáÅÔÇÑÉ ãä ÇáãÚÇãáÇÊ DWT
reconstructed_data = waverec(C, L, waveletName);

% ÑÓã ÇáÅÔÇÑÉ ÇáÃÕáíÉ æÇáãÚÇÏ ÈäÇÄåÇ ááãŞÇÑäÉ
figure;
subplot(3, 1, 1);
plot(data);
title('ÇáÅÔÇÑÉ ÇáÃÕáíÉ');
xlabel('ÇáÒãä');
ylabel('ÇáÓÚÉ');

subplot(3, 1, 2);
plot(reconstructed_data);
title('ÇáÅÔÇÑÉ ÇáãÚÇÏ ÈäÇÄåÇ');
xlabel('ÇáÒãä');
ylabel('ÇáÓÚÉ');
sptool
     
% ãÚÇãáÇÊ İáÊÑ ãËÇá
b = [1 2 1];  % ãÚÇãáÇÊ ÇáÈÓØ
a = [1  -1.6981209373758073  0.96984710693870957]; % ãÚÇãáÇÊ ÇáãŞÇã

% ÊØÈíŞ ÇáİáÊÑ Úáì ÅÔÇÑÉ x
y = filter(b, a, x);

% ÚÑÖ ÇáÅÔÇÑÉ ÇáãİáÊÑÉ

subplot(3, 1, 3);
plot(y);
title('Filtered Signal');
