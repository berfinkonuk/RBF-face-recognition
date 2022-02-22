
% parametre olarak veriln renkli görüntütün özniteliklerini çýkartarak 
% bir boyutlu dizi olarka döndürür.
function satir  = oznitelikCikar(res) 
    % histogram eþitlenior.
    % y cb cr renk uzayýna dönüþütürülüyor.
    b = histeq(res);
    res = rgb2ycbcr(b);
    % resmi boyutlandýrmak için
    boyut = [60 , 60 ];
    % resmin kýrmýzý, yeþil ve mavi
    % kanal deðerleri okunuyor.ç
    k = res(:,:,1) ; 
    y = res(:,:,2) ; 
    m = res(:,:,3) ;     
    k = medfilt2(k);
    y = medfilt2(y);
    m = medfilt2(m);  
   % kanal deðerleri boyutlandýrýlýyor ve kare haline getiriliyor.
    k = imresize(k, boyut);
    y = imresize(y, boyut);
    m = imresize(m, boyut);     
   % her bir kanalýn boyutlandýrýlmuþ hali üzerinde
   % gri düzey eþ oluþum matrisi için 
   % kontrast , korelasyon enerji ve homojenlik deðeri çýkarýlýp sonuca
   % eklniyor.
    a = graycoprops(graycomatrix(k));
    s1 = [a.Contrast a.Correlation a.Energy a.Homogeneity];
    a = graycoprops(graycomatrix(y));
    s2 = [a.Contrast a.Correlation a.Energy a.Homogeneity];
    a = graycoprops(graycomatrix(m));
    s3 = [a.Contrast a.Correlation a.Energy a.Homogeneity];
    satir = [];
    satir = [satir s1]; 
    satir = [satir s2]; 
    satir = [satir s3]; 
    % her bir satýrda local binary pattern öznitelikleri çýkarýlýp
    % sonuca ekleniyor.
    satir = [satir extractLBPFeatures(k)];
    satir = [satir extractLBPFeatures(y)];
    satir = [satir extractLBPFeatures(m)];

end