clc
% k = 3 deðerine göre algorita eðiliyor.
model = fitcknn(egitimGiris', egitimCikis', 'NumNeighbors',3,'Standardize',1)
% eðitim sonucu elde ediliyyor
egitimSonuc =  predict(model,egitimGiris');
% test sonucu elde ediliyyor
testSonuc =  predict(model,testGiris');
clc
% knn eðitim baþarýsý ölüçüyor.
knnEgitimBasarisi =classperf(egitimSonuc, egitimCikis)
% knn test baþarýsý ölçülüyor
knnTestBasarisi =classperf(testSonuc, testCikis)
% eðitim deðerleri ve test deðerleri hesaplanýyor.
egitimDegerleri = olcum(egitimSonuc, egitimCikis)
testDegerleri = olcum(testSonuc, testCikis)