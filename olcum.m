function son=olcum(gercekDegerler, tahminiDegerler)
olumluSinif=max(gercekDegerler);
olumsuzSinif=min(gercekDegerler);
cp=classperf(gercekDegerler,tahminiDegerler,'Positive',olumluSinif,'Negative',olumsuzSinif);
 CM=cp.DiagnosticTable;
    TP=CM(1,1);
    FN=CM(2,1);
    FP=CM(1,2);
    TN=CM(2,2); 
    TP 
    FN
    FP
    TN
    CA=cp.CorrectRate; 
    kesinlik = TP / (TP + FP);
    duyarlilik = TP / (TP + FN);
    f1 = 2 * (kesinlik * duyarlilik) / (kesinlik + duyarlilik); 
    son.kesinlik  = kesinlik;
    son.duyarlilik  = duyarlilik;
    son.f  = f1; 
end