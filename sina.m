close all
clc

ad = imread('test\david1.jpg');
oz = oznitelikCikar(ad);
 
% sonu� .mat dosya�sn� okur
% sinir a��n� elde deder.
load ('sonuc.mat')
karar =  round(sim(sonuc.sinirAgi,oz'))';
karar = find(karar == max(karar));
karar = karar(1) ;
% soncu top hat kodlamadan geri al�r
sonuc.tekil{karar};
 
imshow(ad) ;
title(sonuc.tekil{karar});

