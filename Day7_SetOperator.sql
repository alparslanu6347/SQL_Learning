
/*
==================== SET (küme) OPERATORLERI: UNION, UNION ALL======================
    set=küme diyelim diğer set (sql komutu) ile karışmasın
   
    UNION, UNION ALL, INTERSECT, ve MINUS gibi SET operatorleri yardimiyla
    Çoklu Sorgular birlestirilebilirler. aynı tablodan yada farklı tablodan sütunları birleştirip aynı sütunda yazdırma
    
    UNION :  Bir SET operatorudur. 2 veya daha fazla Sorgu ifadesinin sonuc
    kumelerini birlestirerek tek bir sonuc kumesi olusturur. (iki kümenin birleşimi)

    -- UNION (tekrarlari al)

-- Eger tek sorguda birlestiremeyecegim iki sorgunun sonucunu ayni tabloda
-- gormek istersek UNION islemi kullanilir
-- BU durumda dikkat etmemiz gereken konu iki sorguda da field sayisi ve
-- alt alta gelecek field data tiplerinin ayni olmasidir
   
    -- UNION ALL komutu ise tekrara bakmaksizin iki sorgudan gelen tum sonuclari listeler
    
-- UNION ALL komutunda da iki sorgunun sonucunun esit sayida field'a ve data
-- tiplerine sahip olmasi gereklidir

     SÜTUN birleştirme=> SET
     TABLO birleştirme=> JOIN
     
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    NOT: UNION operatoru SADECE benzersiz degerleri alır. Benzerli verileri almak
    için UNION ALL kullanılır. 
    =========================================================================*/
    
    drop table personel;
    CREATE TABLE personel
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        sehir VARCHAR2(50),
        maas NUMBER(20),
        sirket VARCHAR2(20)
    );
    
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
    SELECT
        * FROM personel;
    
--    ORNEK1: Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas
--  alinan sehirleri ayni sutunda gosteren sorguyu yaziniz. 
    
    SELECT isim, maas FROM personel
    WHERE maas>4000
    UNION ALL -- UNION ALL kullanilirsa tekrarli veriler elenmez, hepsi yazdirilir.
    SELECT sehir, maas FROM personel
    WHERE maas > 5000;
    
    SELECT isim, maas FROM personel
    WHERE maas>4000
    UNION -- UNION kullanilirsa 2 tane olan veri birkez (veli sahin) yazdirilir.
    SELECT sehir, maas FROM personel
    WHERE maas > 5000;
    
--    ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki
--  personelin maaslarini yüksekten alçağa doğru sıralayarak bir tabloda gosteren
--  sorguyu yaziniz.
    
    SELECT isim AS isim_sehir, maas FROM personel
    WHERE isim='Mehmet Ozturk'
    UNION
    SELECT sehir, maas FROM PERSONEL
    WHERE sehir='Istanbul'
    ORDER BY maas DESC;
    
/*======================== FARKLI TABLOLARDAN BIRLESTIRME ====================*/
 --   hata verirse personel i sil bir daha create et
    
    CREATE TABLE personel_bilgi
    (
        id NUMBER(9),
        tel char(10) UNIQUE ,
        cocuk_sayisi NUMBER(2)
      
    );
    
    INSERT INTO personel_bilgi VALUES(123456789, '5302345678' , 5);
    INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
    INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
    INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
    INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
    INSERT INTO personel_bilgi VALUES(453445611, '5524578574', 2);
    INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);
    
--    ORNEK4: id’si 123456789 olan personelin Personel tablosundan sehir ve
--  maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin
---------------------------------------------------------------
    SELECT id, sehir AS sehir_tel, maas AS maas_cocuk_sayisi FROM personel
    WHERE id=123456789
    UNION
    SELECT id, tel, cocuk_sayisi FROM personel_bilgi
    WHERE id=123456789;
    
 /*   ========================= SET OPERATORLERI: INTERSECT ========================
    
    --ıntersect=> iki kümenin kesişimini döndürür.
    
    INTERSECT operarotu 2 veya daha fazla Sorgu ifadesinin sonuclarini
    dondurmek icin kullanilir. Ancak, intersect SADECE tum sorgularin ortak
    verilerini (kesimlerini) dondurur.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    INTERSECT
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK5: Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini
  sorgulayiniz.
  
  Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz.
  Bu iki sorguyu INTERSECT ile birlesitiriniz.
------------------------------------------------------------------------------*/
    
    SELECT id FROM personel
    WHERE sehir IN('Istanbul','Ankara')
    INTERSECT
    SELECT id FROM personel_bilgi
    WHERE cocuk_sayisi IN(2,3);
    
--  ORNEK6: Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
---------------------------------------------------------------
 
    SELECT isim FROM personel
    WHERE sirket='Honda'
    INTERSECT
    SELECT isim FROM personel
    WHERE sirket='Ford'
    INTERSECT
    SELECT isim FROM personel
    WHERE sirket='Tofas';
    
--tek satırda birkaç veri birden isteniyorsa AND ile, 
-- farklı satırlardan ortaklık isteniyorsa INTERSECT


-- ORNEK7: Toyota ve Ford sirketlerinde ayni maasi alan personel isimlerini
--  listeleyin
    SELECT isim, maas FROM personel
    WHERE sirket='Toyota'
    INTERSECT
    SELECT isim, maas FROM personel
    WHERE sirket='Ford';
    
    SELECT isim FROM personel
    WHERE sirket='Toyota'
    INTERSECT
    SELECT isim FROM personel
    WHERE sirket='Ford';
    
 /*   ========================= SET OPERATORLERI: MINUS ============================
    MINUS operatoru ilk Sorgu ifadesinde olup da diger sorgu ifadesinde olmayan
    verileri dondurur. Yani 1. sorgu ile 2. sorgu arasindaki farklı olanları
    dondurur. A-B, SADECE A DAKI DEGERLERI GOSTERIR MINUS ILE.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    MINUS
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
==============================================================================
/* -----------------------------------------------------------------------------
  ORNEK8: 5000’den az maas alan ve Honda calisani olmayanların bilgilerini
  listeleyen bir sorgu yaziniz.
------------------------------------*/
--1nci yontem
SELECT isim, maas, sirket FROM personel
WHERE maas< 5000 
INTERSECT
SELECT isim, maas, sirket FROM personel
WHERE sirket != 'Honda'; -- != yerine <> de kullanilir  

--2nci yontem
SELECT isim, maas, sirket FROM personel
WHERE maas< 5000 
MINUS
SELECT isim, maas, sirket FROM personel
WHERE sirket <> 'Honda'; -- != yerine <> de kullanilir    

-- ORNEK9: Ismi Mehmet Ozturk olup Izmir’de calismayanlarin isimlerini ve
--  sehirlerini listeleyen sorguyu yaziniz.  
    
SELECT isim, sehir FROM personel
WHERE isim='Mehmet Ozturk'
MINUS
SELECT isim, sehir FROM personel
WHERE sehir='Izmir';

-- MINUS TA UNION GIBI TEKRARLI SATIRLARDAN SADECE BIRINI YAZDIRIR.
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    