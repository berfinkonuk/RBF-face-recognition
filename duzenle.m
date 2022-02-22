
% top hat dönüþümünden geriye döner.
function sonuc = duzenle(testCikis)
[en, boy] = size(testCikis) ;

for i = 1 : boy
    sat = testCikis(:,i);
    yer = find(sat == max(sat));
    yer = yer(1);
     sonuc(i) =yer;   
end 
end