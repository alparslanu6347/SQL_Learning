------SUBQUERY--------
--SORGU ICINDE CALISAN SORGUYA SUBQUERY (ALT SORGU) DENIR.

CREATE TABLE personel3
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        sehir VARCHAR2(50),
        maas NUMBER(20),
        sirket VARCHAR2(20)
    );
    
    INSERT INTO personel3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
    INSERT INTO personel3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
    INSERT INTO personel3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
    INSERT INTO personel3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
    INSERT INTO personel3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
    INSERT INTO personel3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
    INSERT INTO personel3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');
    
    CREATE TABLE sirketler
    (
        sirket_id NUMBER(9),
        sirket_adi VARCHAR2(20),
        personel_sayisi NUMBER(20)
    );
    
    INSERT INTO sirketler VALUES(100, 'Honda', 12000);
    INSERT INTO sirketler VALUES(101, 'Ford', 18000);
    INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
    INSERT INTO sirketler VALUES(103, 'Toyota', 21000);
    INSERT INTO sirketler VALUES(104, 'Mazda', 17000);
    
    SELECT *FROM sirketler;
    SELECT * FROM personel3;
    
-- ORNEK1: PERSONEL SAYISI 15.000’den COK OLAN SİRKETLERİN İSİMLERİNİ (alt sorgu şirketler)ve bu
-- sirkette calisan personelin isimlerini ve maaşlarını (asıl sorgu personel) listeleyin

SELECT isim, maas, sirket FROM personel3
WHERE sirket IN(SELECT sirket_adi FROM sirketler 
                WHERE personel_sayisi>15000);

-- ORNEK2: sirket_id’si 101’den büyük olan şirket çalışanlarının isim, maaş ve
--  şehirlerini listeleyiniz.

SELECT isim, maas, sehir FROM personel3
WHERE sirket IN(SELECT sirket_adi FROM sirketler 
                WHERE sirket_id>101);

-- ORNEK3: Ankara’da personeli olan şirketlerin şirket id'lerini ve personel
--  sayılarını listeleyiniz

SELECT sirket_id, personel_sayisi FROM sirketler
WHERE sirket_adi IN(SELECT sirket FROM personel3
                    WHERE sehir='Ankara');

/* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotları(SUM,COUNT, MIN,MAX, AVG) Subquery içinde kullanılabilir.
    Ancak, Sorgu tek bir değer döndürüyor olmalıdır.
-- *** SELECT den sonra SUBQUERY yazarsak sorgu sonucunun sadece 1 deger getireceginden emin olmaliyiz
        --SELECT id,isim,maas
        --FROM personel
        --WHERE sirket='Honda';
-- bir tablodan tek deger getirebilmek icin ortalama AVG , toplam SUM, adet COUNT, MIN, MAX  gibi
-- fonksiyonlar kullanilir ve bu fonksiyonlara AGGREGATE FONKSIYONLAR denir
==============================================================================*/

-- ORNEK4: Her şirketin ismini, personel sayısını ve o şirkete ait personelin
--  toplam maaşını listeleyen bir Sorgu yazınız.

SELECT sirket_adi, personel_sayisi, (SELECT SUM(maas) FROM personel3 
                                        WHERE sirketler.sirket_adi=personel3.sirket) AS toplam_maas 


FROM sirketler;

-- AS TAKISIYLA ISTEDIGIMIZ SUTUNA ISTEDIGIMIZ ADI VEREBILIRIZ.

-- ORNEK5: Her şirketin ismini, personel sayısını ve o şirkete ait personelin
--  ortalama maaşını listeleyen bir Sorgu yazınız.

SELECT sirket_adi, personel_sayisi, (SELECT ROUND (AVG(maas)) FROM personel3
                                            WHERE sirket_adi=sirket) AS ort_maas
                                            FROM SIRKETLER;

-- ORNEK6: Her şirketin ismini, personel sayısını ve o şirkete ait personelin
-- maksimum ve minumum maaşını listeleyen bir Sorgu yazınız.

SELECT sirket_adi, personel_sayisi, (SELECT MAX(maas) FROM personel3
                                        WHERE sirket_adi=sirket) AS max_maas,
                                        (SELECT MIN(maas) FROM personel3
                                        WHERE sirket_adi=sirket) AS min_maas

FROM sirketler;

-- ORNEK7: Her sirketin id’sini, ismini ve toplam kaç şehirde bulunduğunu
--  listeleyen bir SORGU yazınız.

SELECT sirket_id, sirket_adi, (SELECT COUNT(sehir) FROM personel3
                                WHERE sirket=sirket_adi) AS sehir_sayisi
FROM sirketler;


-- ODEVVVV
    -- sirket id, sirket ismi, sirketteki min maas, sirketteki max maas, sirketteki ort.maas lari yazdirin
    -- izmir,istanbul veya bursada personeli bulunan sirketlerin calisan sayilarini listeleyin
    -- izmirde calisan Veli YIlmaz'in maasini 2000 yapin
    -- personel sayisi 10000 olan sirketten personel  tablosunda bulunan kisinin maasini 6000 yapin














