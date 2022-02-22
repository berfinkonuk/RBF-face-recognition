
% parametre olarak veriln renkli g�r�nt�t�n �zniteliklerini ��kartarak 
% bir boyutlu dizi olarka d�nd�r�r.
function satir  = oznitelikCikar(res) 
    % histogram e�itlenior.
    % y cb cr renk uzay�na d�n���t�r�l�yor.
    b = histeq(res);
    res = rgb2ycbcr(b);
    % resmi boyutland�rmak i�in
    boyut = [60 , 60 ];
    % resmin k�rm�z�, ye�il ve mavi
    % kanal de�erleri okunuyor.�
    k = res(:,:,1) ; 
    y = res(:,:,2) ; 
    m = res(:,:,3) ;     
    k = medfilt2(k);
    y = medfilt2(y);
    m = medfilt2(m);  
   % kanal de�erleri boyutland�r�l�yor ve kare haline getiriliyor.
    k = imresize(k, boyut);
    y = imresize(y, boyut);
    m = imresize(m, boyut);     
   % her bir kanal�n boyutland�r�lmu� hali �zerinde
   % gri d�zey e� olu�um matrisi i�in 
   % kontrast , korelasyon enerji ve homojenlik de�eri ��kar�l�p sonuca
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
    % her bir sat�rda local binary pattern �znitelikleri ��kar�l�p
    % sonuca ekleniyor.
    satir = [satir extractLBPFeatures(k)];
    satir = [satir extractLBPFeatures(y)];
    satir = [satir extractLBPFeatures(m)];

end