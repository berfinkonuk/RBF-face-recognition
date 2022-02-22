clc
 % e�tim giri� , e�itim ��k�� de�i�kenleri silinoy.r
clear egitimGiris
clear egitimCikis
clear testGiris
clear testCikis
sayac1 = 1;
sayac2 = 1;

% e�itim ve test klas�rleri silinip s�f�rdan olu�turuluyor.
 if exist('egitim', 'dir')
    rmdir('egitim','s')
 end
 if exist('test', 'dir')
    rmdir('test','s')
 end  

mkdir('egitim')
mkdir('test')

% ki�ilerin numaras� yeniden veriliyor. S�raylar
tekil = unique(tekil);
for i = 1 : numel(kisiler)
    
    no = find ( strcmp(    kisiler{i}.ad , tekil ) == 1);
    kisiler{i}.numara = no;
end 
 




% b�t�n ki�iler i�in top hat kodlama yap�l�yor.
for i = 1 : numel(kisiler)    
        %e�itmde kullan�lacka ki�ilkeri e�itim klas�r�ne
        % test kullan�lacka ki�ileri test klas�r�ne takr�y�rpz.
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

fprintf('Olu�turuldu\n'); 


% e�itim ve testi double veri t�r�ne d�r��n��yl�po.
egitimGiris = double(egitimGiris);  
testGiris = double(testGiris); 
amac = 0.0;
yayilim = 0.4;
MN = 3000;
DF = 5;
% radyal tabanl� sinir a�� e�itiliyor.
[sinirAgi, tr] = newrb(egitimGiris,egitimCikis, amac,yayilim,MN,DF);
testSonuc = round(sim(sinirAgi,testGiris)) ;
egitimSonuc = round(sim(sinirAgi,egitimGiris)) ;

testSonuc = duzenle(testSonuc);
testCikis = duzenle(testCikis);


egitimSonuc = duzenle(egitimSonuc);
egitimCikis = duzenle(egitimCikis);

% e�itim ve test ba�ar�lar� �l��l�r.

rbfEgitimBasarisi =classperf(egitimSonuc, egitimCikis) 
fprintf('\n\n ');
rbfTestBasarisi = classperf(testSonuc, testCikis)

% ki�i adlar� ve sinir a�� sonuc.amt dosyas� i�ine kaydedilir.
sonuc.sinirAgi = sinirAgi;
sonuc.tekil = tekil;
save('sonuc.mat', 'sonuc');

fprintf('E�itim tamamland�\n');



egitimDegerleri = olcum(egitimSonuc, egitimCikis)
testDegerleri = olcum(testSonuc, testCikis)

 