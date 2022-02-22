close all
clc

ad = imread('test\david1.jpg');
oz = oznitelikCikar(ad);
 
% sonuç .mat dosyaýsný okur
% sinir aðýný elde deder.
load ('sonuc.mat')
karar =  round(sim(sonuc.sinirAgi,oz'))';
karar = find(karar == max(karar));
karar = karar(1) ;
% soncu top hat kodlamadan geri alýr
sonuc.tekil{karar};
 
imshow(ad) ;
title(sonuc.tekil{karar});

