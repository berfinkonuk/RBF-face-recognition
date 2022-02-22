clc
% karar a�ac� e�itim giri ve ��k���na g�re e�itiliyor
agac = fitctree(egitimGiris', egitimCikis' )
% a�a� ekranda g�steriliyor
view(agac)
% e�itim sonucu elde ediliyyor
egitimSonuc =  predict(agac,egitimGiris');
% test sonucu elde ediliyor
testSonuc =  predict(agac,testGiris');
%a�a� grafik olarak g�steriliyor
view(agac,'Mode','graph')
% a�a� e�itim ba�ar�s� �l��l�yor
agacEgitimBasarisi =classperf(egitimSonuc, egitimCikis)
% test ba�ar�s� �l��l�yor.
agacTestBasarisi =classperf(testSonuc, testCikis)
% e�itim ve test ba�ar�lar� daha ayr�nt�l� �l��l�yor.
egitimDegerleri = olcum(egitimSonuc, egitimCikis)
testDegerleri = olcum(testSonuc, testCikis)