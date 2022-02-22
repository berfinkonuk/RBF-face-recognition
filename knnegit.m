clc
% k = 3 de�erine g�re algorita e�iliyor.
model = fitcknn(egitimGiris', egitimCikis', 'NumNeighbors',3,'Standardize',1)
% e�itim sonucu elde ediliyyor
egitimSonuc =  predict(model,egitimGiris');
% test sonucu elde ediliyyor
testSonuc =  predict(model,testGiris');
clc
% knn e�itim ba�ar�s� �l���yor.
knnEgitimBasarisi =classperf(egitimSonuc, egitimCikis)
% knn test ba�ar�s� �l��l�yor
knnTestBasarisi =classperf(testSonuc, testCikis)
% e�itim de�erleri ve test de�erleri hesaplan�yor.
egitimDegerleri = olcum(egitimSonuc, egitimCikis)
testDegerleri = olcum(testSonuc, testCikis)