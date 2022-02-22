% ekran� kapatma ve temizleme i�lemi
close all
clear
clc 

% e�er e�itim diye bir klas�r varsa silinioyor.
 if exist('egitim', 'dir')
    rmdir('egitim','s')
 end
% e�er test diye bir klas�r varsa silinioyor.
 if exist('test', 'dir')
    rmdir('test','s')
 end  

 % e�itim ve test klas�rleri s�f�rdan olu�turuloy�r
mkdir('egitim')
mkdir('test')


% kaynak klas�r�ndeki b�t�n dosyalar� okur.
dosyalar = dir('kaynak');
 
sayac = 1 ;
for i = 1 : numel(dosyalar)
    siradaki = dosyalar(i);
    
    
    % e�er ad� . ya da .. ise ge�er
    ad = siradaki.name;
    if(numel(ad) < 3 )
        continue;
    end
    
    % ad�ndaki rakamlar� kald�r�r
    % ayr�ca dosya uzant�s�n� kald�r�r .
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
    
    % ki�inin ad� 
    % dosyas�n�n ad� ve dosya konumu 
    % burada saklan�r.
    kisi.ad = ad;
    kisi.dosya = siradaki.name;
    kisi.konum = [siradaki.folder, '\',siradaki.name];
    res = imread(kisi.konum);
    kisi.oznitelik = oznitelikCikar(res);
    
    % dosyalar�n y�zde ka��n� okudu�unu ekranda yaz�yor 
    % �nemi yok.
    oran = 100 * sayac / numel(dosyalar);
    oran = round(oran);
    metin =['Okunma oran� % : ',num2str(oran)];
    clc
    disp(metin)
    
    
    % kay�tlar listesine ald�
    kayitlar{sayac} = kisi;
    % her biri�inin ad�n� da adlar listeisne ald�
    adlar{sayac} = ad;
    sayac = sayac + 1;
    
end
% adlar listeki tekil hale gitirilyor.
adlar = unique(adlar)';

% her ki�iinin ad�na denk gelen bir numara veriyor.
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

% test oran� belirlendi. Veriler e�itim yada test olarak ikiye b�l�nd�.
testOrani = 0.1;
for i = 1 : kisiSayisi 
    % her bir numara ki�ilerin numalar�n� tutar.
    uyanlar  =  find(numaralar == i) ;
    sayisi = numel(uyanlar);
    
    % e�er ki�inin foto�raf say�s� 12'den az ise devam edilir.
    if(sayisi < 12)   
        for k =1 : numel(uyanlar)
            kayitlar{uyanlar(k)}.egitimmi = -1;
        end
        
        continue 
    end
       
   
     % ki�inin foto�raflar�ndan test i�in kullan�lacaklar�n say�s�
     % belirlenir 
    test = round(sayisi * testOrani ) ;
    if(test == 0)
        continue;
    end
    
    
   % test fotolar� belirlenir ve egitimmi alan� 0 yap�l�r 
   % bu s�rakida kayd�n test i�in kullan�laca��na i�aret eder.
    testFotolari =  uyanlar(1:test);

    for k = 1 : numel(testFotolari)
        kayitlar{testFotolari(k)}.egitimmi = 0;
    end
        

end 
%ki�i adlar� tekil hale getirilir.
kisiler = kayitlar;
for i = 1 : numel(kisiler)
    tekil{i} = kisiler{i}.ad;
end 
tekil =unique(tekil);

fprintf('Test olanlar belirlendi');