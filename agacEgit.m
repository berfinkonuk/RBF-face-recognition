clc
% karar aðacý eðitim giri ve çýkýþýna göre eðitiliyor
agac = fitctree(egitimGiris', egitimCikis' )
% aðaç ekranda gösteriliyor
view(agac)
% eðitim sonucu elde ediliyyor
egitimSonuc =  predict(agac,egitimGiris');
% test sonucu elde ediliyor
testSonuc =  predict(agac,testGiris');
%aðaç grafik olarak gösteriliyor
view(agac,'Mode','graph')
% aðaç eðitim baþarýsý ölçülüyor
agacEgitimBasarisi =classperf(egitimSonuc, egitimCikis)
% test baþarýsý ölçülüyor.
agacTestBasarisi =classperf(testSonuc, testCikis)
% eðitim ve test baþarýlarý daha ayrýntýlý ölçülüyor.
egitimDegerleri = olcum(egitimSonuc, egitimCikis)
testDegerleri = olcum(testSonuc, testCikis)