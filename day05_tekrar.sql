

CREATE TABLE mart_satislar1
    (
        urun_id number(10),
        musteri_isim varchar2(50),
        urun_isim varchar2(50)
    );
    
    CREATE TABLE nisan_satislar1
    (
        urun_id number(10),
        musteri_isim varchar2(50),
        urun_isim varchar2(50)
    );
    
    INSERT INTO mart_satislar1 VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar1 VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar1 VALUES (20, 'John', 'Toyota');
    INSERT INTO mart_satislar1 VALUES (30, 'Amy', 'Ford');
    INSERT INTO mart_satislar1 VALUES (20, 'Mark', 'Toyota');
    INSERT INTO mart_satislar1 VALUES (10, 'Adem', 'Honda');
    INSERT INTO mart_satislar1 VALUES (40, 'John', 'Hyundai');
    INSERT INTO mart_satislar1 VALUES (20, 'Eddie', 'Toyota');
    
    INSERT INTO nisan_satislar1 VALUES (10, 'Hasan', 'Honda');
    INSERT INTO nisan_satislar1 VALUES (10, 'Kemal', 'Honda');
    INSERT INTO nisan_satislar1 VALUES (20, 'Ayse', 'Toyota');
    INSERT INTO nisan_satislar1 VALUES (50, 'Yasar', 'Volvo');
    INSERT INTO nisan_satislar1 VALUES (20, 'Mine', 'Toyota');
    
    SELECT * FROM mart_satislar1;
    SELECT * FROM nisan_satislar1;
    
-- ORNEK1: MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
-- URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
-- MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
    
    SELECT urun_id, musteri_isim FROM mart_satislar1 
    WHERE EXISTS(SELECT urun_id FROM nisan_satislar1 
                    WHERE nisan_satislar1.urun_id = mart_satislar1.urun_id);
                    
     SELECT urun_id, musteri_isim FROM mart_satislar1
    WHERE urun_id IN (SELECT urun_id FROM nisan_satislar1
                        WHERE mart_satislar1.urun_id=nisan_satislar1.urun_id);               
    
--   ORNEK2: Her iki ayda da satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--   NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
    
   SELECT urun_isim, musteri_isim FROM nisan_satislar1 n
   WHERE EXISTS(SELECT urun_isim FROM mart_satislar1 m
                WHERE m.urun_isim=n.urun_isim);
    
 --  ORNEK3: Her iki ayda da ortak olarak satılmayan ürünlerin URUN_ISIM'lerini
--  ve bu ürünleri NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyiniz. 
    
   SELECT urun_isim, musteri_isim FROM nisan_satislar1
   WHERE NOT EXISTS(SELECT urun_isim FROM mart_satislar1
                WHERE nisan_satislar1.urun_isim=mart_satislar1.urun_isim);
   
/* ======= IS NULL, IS NOT NULL, COALESCE(kulesk=birleşmek) ==================
    IS NULL, ve IS NOT NULL BOOLEAN operatörleridir. Bir ifadenin NULL olup
    olmadığını kontrol ederler.
==============================================================================*/
    CREATE TABLE insanlar1
    (
        ssn CHAR(9),
        isim VARCHAR2(50),
        adres VARCHAR2(50)
    );
    
    INSERT INTO insanlar1 VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar1 VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar1 VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar1 (ssn, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar1 (ssn, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar1 (adres) VALUES('Sakarya');
    INSERT INTO insanlar1 (ssn) VALUES('999111222');   
    
    SELECT * FROM insanlar1;
    
    drop table insanlar;
    
  -- ORNEK1 : ISIM‘I NULL OLANLARI SORGULAYINIZ
  
  SELECT * FROM insanlar1
  WHERE isim IS NULL;
    
  -- ORNEK2: ISMI NULL OLMAYANLARI SORGULA  
    
    SELECT * FROM insanlar1
    WHERE isim IS NOT NULL;
    
-- ORNEK3: ISMI NULL OLAN KISILERIN ISIM‘INE NO NAME,SEHIRE NO CITY ATAYINIZ.
    
  UPDATE insanlar1 SET isim='NO NAME'
  WHERE isim IS NULL;

SELECT * FROM insanlar1;
   
   UPDATE insanlar1 SET adres='NO CITY'
   WHERE adres IS NULL;
   
   SELECT COALESCE (isim, ssn, adres) FROM insanlar1;
   
   -- ornek4: tablodaki butun null verileri guzel bir cumlecikle degistirin
   
   UPDATE insanlar1 SET isim=COALESCE(isim, 'henuz isim girilmedi'),
   adres=COALESCE(adres, 'henuz adres girilmedi'),
   ssn=COALESCE(ssn, 'NO SSN');
   
    SELECT * FROM insanlar1;
   
   /*  ================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN’a göre
   SIRALAMA yapmak için kullanılır.
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
============================================================================  */

CREATE TABLE kisiler1
    (
        ssn CHAR(9) PRIMARY KEY,
        isim VARCHAR2(50),
        soyisim VARCHAR2(50),
        maas NUMBER,
        adres VARCHAR2(50)
    );
    
    INSERT INTO kisiler1 VALUES(123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler1 VALUES(234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler1 VALUES(345678901, 'Mine','Bulut',4200,'Ankara');
    INSERT INTO kisiler1 VALUES(256789012, 'Mahmut','Bulut',3150,'Istanbul');
    INSERT INTO kisiler1 VALUES (344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler1 VALUES (345458901, 'Veli','Yilmaz',7000,'Istanbul');
    
    SELECT * FROM kisiler1;
    
/* ----------------------------------------------------------------------------
  ORNEK1: kisiler tablosunu adres'e göre sıralayarak sorgulayınız.
 -----------------------------------------------------------------------------*/
    
    SELECT * FROM kisiler1
    ORDER BY adres;
    
    
-- ORNEK2: kisiler tablosunu maas'a göre ters (azalan) sıralayarak sorgulayınız.
    
    SELECT * FROM kisiler1
    ORDER BY maas DESC;
    
 -- ORNEK3: kisiler tablosunu maas'a göre ters (azalan) sıralayarak sorgulayınız.   

SELECT * FROM kisiler1
ORDER BY maas ASC;
    
 --   ORNEK4: ismi Mine olanları, SSN'e göre AZALAN(DESC) sırada sorgulayınız.
    
    SELECT * FROM kisiler1
    WHERE isim='Mine'
    ORDER BY ssn DESC;
    
--   ORNEK5: soyismi 'i Bulut olanları isim sıralı olarak sorgulayınız.
-----------------------------------------------------------------------------* 
   SELECT * FROM kisiler1
    WHERE soyisim='Bulut'
    ORDER BY 2;  -- isim yerine ismin sutun sirasi olan 2‘yi kullanabiliriz. 
    
   /*====================== FETCH NEXT, OFFSET (12C VE ÜSTÜ oracle larda çalışır, daha altsanız çalışmaz) ======================
   FETCH cümleciği ile listelenecek kayıtları sınırlandırabiliriz. İstersek
   satır sayısına göre istersek de toplam satır sayısının belli bir yüzdesine
   göre sınırlandırma koymak mümkündür. (şu kadar satırı getir)
   Syntax
   ---------
   FETCH NEXT satir_sayisi ROWS ONLY;
   FETCH NEXT satir_yuzdesi PERCENT ROWS ONLY;
   OFFSET Cümleciği ile de listenecek olan satırlardan sırasıyla istediğimiz
   kadarını atlayabiliriz.
   Syntax
   ----------
   OFFSET satır_sayisi ROWS;
==============================================================================*/
/* ----------------------------------------------------------------------------
  ORNEK1: MAAŞ'ı en yüksek 3 kişinin bilgilerini listeleyen sorguyu yazınız. */
  
  SELECT * FROM kisiler1
  ORDER BY maas DESC
  FETCH NEXT 3 ROWS ONLY;
 
    
--  ORNEK2: MAAŞ'ı en DÜŞÜK 2 kişinin bilgilerini listeleyen sorguyu yazınız.  
    
    SELECT * FROM kisiler1
    ORDER BY maas ASC
    FETCH NEXT 2 ROWS ONLY;
    
   
--  ORNEK3: MAAŞ'a göre (azalan) sıralamada 4. 5. ve 6. kişilerin bilgilerini listeleyen
--  sorguyu yazınız. 
    
    SELECT * FROM kisiler1
    ORDER BY maas DESC
    OFFSET 3 ROWS FETCH NEXT 3 ROWS ONLY;
    
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   