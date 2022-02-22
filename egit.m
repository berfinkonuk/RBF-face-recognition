clc
 % eðtim giriþ , eðitim çýkýþ deðiþkenleri silinoy.r
clear egitimGiris
clear egitimCikis
clear testGiris
clear testCikis
sayac1 = 1;
sayac2 = 1;

% eðitim ve test klasörleri silinip sýfýrdan oluþturuluyor.
 if exist('egitim', 'dir')
    rmdir('egitim','s')
 end
 if exist('test', 'dir')
    rmdir('test','s')
 end  

mkdir('egitim')
mkdir('test')

% kiþilerin numarasý yeniden veriliyor. Sýraylar
tekil = unique(tekil);
for i = 1 : numel(kisiler)
    
    no = find ( strcmp(    kisiler{i}.ad , tekil ) == 1);
    kisiler{i}.numara = no;
end 
 




% bütün kiþiler için top hat kodlama yapýlýyor.
for i = 1 : numel(kisiler)    
        %eðitmde kullanýlacka kiþilkeri eðitim klasörüne
        % test kullanýlacka kiþileri test klasörüne takrýyýrpz.
    if(kisiler{i}.egitimmi == 1)
        egitimGiris(:,sayac1) = kisiler{i}.oznitelik;
        %
        satir = zeros(1,numel(tekil));
        satir(kisiler{i}.numara) = 1;        
        egitimCikis(:,sayac1) = satir ;
        sayac1 = sayac1 + 1;
        
        DestinyFile = ['egitim\',kisiler{i}.dosya];
        copyfile(kisiler{i}.konum, DestinyFile, 'f')
        
    end
    if(kisiler{i}.egitimmi == 0)        
        satir = zeros(1,numel(tekil));
        satir(kisiler{i}.numara) = 1;        
        testGiris(:,sayac2) = kisiler{i}.oznitelik;
        testCikis(:,sayac2) =satir;
        sayac2 = sayac2 + 1;        
        DestinyFile = ['test\',kisiler{i}.dosya];
        copyfile(kisiler{i}.konum, DestinyFile, 'f')
    end
end

fprintf('Oluþturuldu\n'); 


% eðitim ve testi double veri türüne dörüþnüüylüpo.
egitimGiris = double(egitimGiris);  
testGiris = double(testGiris); 
amac = 0.0;
yayilim = 0.4;
MN = 3000;
DF = 5;
% radyal tabanlý sinir aðý eðitiliyor.
[sinirAgi, tr] = newrb(egitimGiris,egitimCikis, amac,yayilim,MN,DF);
testSonuc = round(sim(sinirAgi,testGiris)) ;
egitimSonuc = round(sim(sinirAgi,egitimGiris)) ;

testSonuc = duzenle(testSonuc);
testCikis = duzenle(testCikis);


egitimSonuc = duzenle(egitimSonuc);
egitimCikis = duzenle(egitimCikis);

% eðitim ve test baþarýlarý ölçülür.

rbfEgitimBasarisi =classperf(egitimSonuc, egitimCikis) 
fprintf('\n\n ');
rbfTestBasarisi = classperf(testSonuc, testCikis)

% kiþi adlarý ve sinir aðý sonuc.amt dosyasý içine kaydedilir.
sonuc.sinirAgi = sinirAgi;
sonuc.tekil = tekil;
save('sonuc.mat', 'sonuc');

fprintf('Eðitim tamamlandý\n');



egitimDegerleri = olcum(egitimSonuc, egitimCikis)
testDegerleri = olcum(testSonuc, testCikis)

 