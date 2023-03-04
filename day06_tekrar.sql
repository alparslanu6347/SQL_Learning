


CREATE TABLE manav1
    (
        isim varchar2(50),
        urun_adi varchar2(50),
        urun_miktari number(9)
    );
    
    INSERT INTO manav1 VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav1 VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav1 VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav1 VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav1 VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav1 VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav1 VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav1 VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav1 VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav1 VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav1 VALUES( 'Ali', '', 2);
    
    SELECT * FROM MANAV1;
    
    
    -- ORNEK1: kisi ismine göre satılan toplam meyve miktarlarını gösteren sorguyu
 -- yazınız. ali=>5+2+2+2 sum= meyve sayılarını toplucak    -- veli 9
                                                            -- ayse 10
 SELECT isim, SUM(urun_miktari) toplam_meyve_miktari FROM manav1
 GROUP BY isim;
 
 
-- ORNEK2: satılan meyve türüne (urun_adi) göre urun alan kişi sayısını gösteren
--  sorguyu yazınız. NULL olarak girilen meyveyi listelemesin.count= elma alan kişileri sayacak
                            -- elma 4
                            -- armut 3
-----------------------------

SELECT urun_adi, COUNT(isim) kisi_sayisi FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi;