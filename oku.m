% ekraný kapatma ve temizleme iþlemi
close all
clear
clc 

% eðer eðitim diye bir klasör varsa silinioyor.
 if exist('egitim', 'dir')
    rmdir('egitim','s')
 end
% eðer test diye bir klasör varsa silinioyor.
 if exist('test', 'dir')
    rmdir('test','s')
 end  

 % eðitim ve test klasörleri sýfýrdan oluþturuloyþr
mkdir('egitim')
mkdir('test')


% kaynak klasöründeki bütün dosyalarý okur.
dosyalar = dir('kaynak');
 
sayac = 1 ;
for i = 1 : numel(dosyalar)
    siradaki = dosyalar(i);
    
    
    % eðer adý . ya da .. ise geçer
    ad = siradaki.name;
    if(numel(ad) < 3 )
        continue;
    end
    
    % adýndaki rakamlarý kaldýrýr
    % ayrýca dosya uzantýsýný kaldýrýr .
    ad = strrep(ad, '0', '') ;
    ad = strrep(ad, '1', '') ;
    ad = strrep(ad, '2', '') ;
    ad = strrep(ad, '3', '') ;
    ad = strrep(ad, '4', '') ;
    ad = strrep(ad, '5', '') ;
    ad = strrep(ad, '6', '') ;
    ad = strrep(ad, '7', '') ;
    ad = strrep(ad, '8', '') ;
    ad = strrep(ad, '9', '') ;
    ad = strrep(ad, '.', '') ;
    ad = strrep(ad, '10', '') ;
    ad = strrep(ad, 'jpg', '') ;
    ad = strrep(ad, '!', '') ;
    
    % kiþinin adý 
    % dosyasýnýn adý ve dosya konumu 
    % burada saklanýr.
    kisi.ad = ad;
    kisi.dosya = siradaki.name;
    kisi.konum = [siradaki.folder, '\',siradaki.name];
    res = imread(kisi.konum);
    kisi.oznitelik = oznitelikCikar(res);
    
    % dosyalarýn yüzde kaçýný okuduðunu ekranda yazýyor 
    % önemi yok.
    oran = 100 * sayac / numel(dosyalar);
    oran = round(oran);
    metin =['Okunma oraný % : ',num2str(oran)];
    clc
    disp(metin)
    
    
    % kayýtlar listesine aldý
    kayitlar{sayac} = kisi;
    % her biriþinin adýný da adlar listeisne aldý
    adlar{sayac} = ad;
    sayac = sayac + 1;
    
end
% adlar listeki tekil hale gitirilyor.
adlar = unique(adlar)';

% her kiþiinin adýna denk gelen bir numara veriyor.
numaralar = zeros(1, numel(kayitlar));
for i = 1 : numel(kayitlar)
    isim = kayitlar{i}.ad;
    numara = find(strcmp( adlar,  isim) == 1 );
    kayitlar{i}.numara = numara;    
    kayitlar{i}.egitimmi = 1;
    numaralar(i) = numara;
end 

kisiSayisi = numel(adlar);
clc

% test oraný belirlendi. Veriler eðitim yada test olarak ikiye bölündü.
testOrani = 0.1;
for i = 1 : kisiSayisi 
    % her bir numara kiþilerin numalarýný tutar.
    uyanlar  =  find(numaralar == i) ;
    sayisi = numel(uyanlar);
    
    % eðer kiþinin fotoðraf sayýsý 12'den az ise devam edilir.
    if(sayisi < 12)   
        for k =1 : numel(uyanlar)
            kayitlar{uyanlar(k)}.egitimmi = -1;
        end
        
        continue 
    end
       
   
     % kiþinin fotoðraflarýndan test için kullanýlacaklarýn sayýsý
     % belirlenir 
    test = round(sayisi * testOrani ) ;
    if(test == 0)
        continue;
    end
    
    
   % test fotolarý belirlenir ve egitimmi alaný 0 yapýlýr 
   % bu sýrakida kaydýn test için kullanýlacaðýna iþaret eder.
    testFotolari =  uyanlar(1:test);

    for k = 1 : numel(testFotolari)
        kayitlar{testFotolari(k)}.egitimmi = 0;
    end
        

end 
%kiþi adlarý tekil hale getirilir.
kisiler = kayitlar;
for i = 1 : numel(kisiler)
    tekil{i} = kisiler{i}.ad;
end 
tekil =unique(tekil);

fprintf('Test olanlar belirlendi');