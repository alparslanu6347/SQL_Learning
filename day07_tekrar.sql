

 CREATE TABLE personel6
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        sehir VARCHAR2(50),
        maas NUMBER(20),
        sirket VARCHAR2(20)
    );
    
    INSERT INTO personel6 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel6 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel6 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
    INSERT INTO personel6 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel6 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel6 VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    INSERT INTO personel6 VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
    SELECT
        * FROM personel6;
    
--    ORNEK1: Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas
--  alinan sehirleri ayni sutunda gosteren sorguyu yaziniz. 
    
   SELECT isim, maas from personel6
   where maas>4000
  UNION ALL 
   SELECT sehir, maas from personel6
   where maas>5000;
   
    SELECT isim, maas from personel6
   where maas>4000
  UNION 
   SELECT sehir, maas from personel6
   where maas>5000;
    
--    ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki
--  personelin maaslarini yüksekten alçağa doğru sıralayarak bir tabloda gosteren
--  sorguyu yaziniz.
    
    SELECT isim AS isim_sehir, maas from personel6
    where isim='Mehmet Ozturk'
    UNION ALL
    select sehir, maas from personel6
    where sehir='Istanbul'
    ORDER BY maas;
    
    
     CREATE TABLE personel_bilgi1
    (
        id NUMBER(9),
        tel char(10) UNIQUE ,
        cocuk_sayisi NUMBER(2)
      
    );
    
    INSERT INTO personel_bilgi1 VALUES(123456789, '5302345678' , 5);
    INSERT INTO personel_bilgi1 VALUES(234567890, '5422345678', 4);
    INSERT INTO personel_bilgi1 VALUES(345678901, '5354561245', 3);
    INSERT INTO personel_bilgi1 VALUES(456789012, '5411452659', 3);
    INSERT INTO personel_bilgi1 VALUES(567890123, '5551253698', 2);
    INSERT INTO personel_bilgi1 VALUES(453445611, '5524578574', 2);
    INSERT INTO personel_bilgi1 VALUES(123456710, '5537488585', 1);
    
--    ORNEK4: id’si 123456789 olan personelin Personel tablosundan sehir ve
--  maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin
---------------------------------------------------------------
   
   select id, sehir AS sehir_tel, maas AS maas_cocuk_sayisi from personel6
   where id=123456789
    UNION
    select id, tel, cocuk_sayisi from personel_bilgi1
    where id=123456789;
    
    /* -----------------------------------------------------------------------------
  ORNEK5: Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini
  sorgulayiniz.
  
  Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz.
  Bu iki sorguyu INTERSECT ile birlesitiriniz.
------------------------------------------------------------------------------*/
    select id from personel6
    where sehir IN('Istanbul','Ankara')
    INTERSECT
    select id from personel_bilgi1
    where cocuk_sayisi IN(2,3);
    
--  ORNEK6: Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
---------------------------------------------------------------
 SELECT isim from personel6
 where sirket='Honda'
    INTERSECT
   SELECT isim from personel6
 where sirket='Ford'
 INTERSECT
 SELECT isim from personel6
 where sirket='Tofas';
 
--tek satırda birkaç veri birden isteniyorsa AND ile, 
-- farklı satırlardan ortaklık isteniyorsa INTERSECT


-- ORNEK7: Toyota ve Ford sirketlerinde ayni maasi alan personel isimlerini
--  listeleyin
   
    select isim, maas from personel6
    where sirket='Toyota'
    INTERSECT
    select isim, maas from personel6
    where sirket='Ford';
    
    /* -----------------------------------------------------------------------------
  ORNEK8: 5000’den az maas alan ve Honda calisani olmayanların bilgilerini
  listeleyen bir sorgu yaziniz.
------------------------------------*/

SELECT isim, maas, sirket from personel6
where maas<5000
INTERSECT
select isim, maas, sirket from personel6
where sirket <> 'Honda';

-- ORNEK9: Ismi Mehmet Ozturk olup Izmir’de calismayanlarin isimlerini ve
--  sehirlerini listeleyen sorguyu yaziniz.  
    select isim, sehir from personel6
    where isim='Mehmet Ozturk'
    INTERSECT
    select isim, sehir from personel6
    where sehir <>'Izmir';


-- MINUS TA UNION GIBI TEKRARLI SATIRLARDAN SADECE BIRINI YAZDIRIR.
    
    
    
    
    
    
    
    
    
   