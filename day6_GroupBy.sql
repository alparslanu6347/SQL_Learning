/*
============================ GROUP BY =====================================
    GROUP BY cümleciği bir SELECT ifadesinde satırları, sutunların değerlerine
    göre özet olarak gruplamak için kullanılır.
    GROUP BY cümleceği her grup başına bir satır döndürür.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonları ile birlikte kullanılır.
    
*/

CREATE TABLE manav
    (
        isim varchar2(50),
        urun_adi varchar2(50),
        urun_miktari number(9)
    );
    
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', '', 2);
    
    SELECT * FROM MANAV;
    
 -- ORNEK1: kisi ismine göre satılan toplam meyve miktarlarını gösteren sorguyu
 -- yazınız. ali=>5+2+2+2 sum= meyve sayılarını toplucak    -- veli 9
                                                            -- ayse 10
 
 SELECT isim, SUM(urun_miktari) toplam_urun FROM manav
 GROUP BY isim; -- isim isim grupla, her ismi bir kere yaz, 
 -- o isimdeki meyve sayilarini topla, ilgili ismin satirinda goster
 
-- ORNEK2: satılan meyve türüne (urun_adi) göre urun alan kişi sayısını gösteren
--  sorguyu yazınız. NULL olarak girilen meyveyi listelemesin.count= elma alan kişileri sayacak
                            -- elma 4
                            -- armut 3
-----------------------------

SELECT urun_adi, COUNT (isim) kisi_sayisi FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi;

-- ORNEK3: satılan meyve türüne (URUN_ADİ) göre satılan (urun_miktari )MIN ve
--  MAX urun miktarlarini, MAX urun miktarina göre SIRALAYARAK listeyen sorguyu
--  yazınız.
     --min max
-- elma 2   5
--armut 2   3

SELECT urun_adi, MIN(urun_miktari), MAX(urun_miktari) FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi
ORDER BY MAX(urun_miktari) DESC;

/*
*******SIRALAMA AŞAĞIDAKİ GİBİ OLMALI********
  =>SELECT FROM
  =>WHERE  1)gruplamadan bazı şartlara göre bazılarını ele
  =>GROUP BY 2)özelliklerine göre grupla
  =>HAVİNG (BİRAZDAN ÖĞRENİCEZ)3) grup özelliklerine göre şartla ele. ya where ya having yani
  =>ORDER BY  4) bu grupları istenilen özelliğe göre sırala   */
  
-- ORNEK4: kisi ismine ve urun adına (select) göre satılan ürünlerin (sum)toplamını
--  gruplandıran ve önce isme göre sonra urun_adi na göre ters sırayla (order by) listeyen sorguyu yazınız.
--  önce isme göre sonra meyvelere=  

SELECT isim, urun_adi, SUM(urun_miktari) FROM manav
GROUP BY isim, urun_adi
ORDER BY isim, urun_adi DESC; 

/*
ORNEK5: kisi ISMİNE ve URUN ADINA göre, satılan ürünlerin toplamını bulan ve
   ** SELECT ISİM, URUN_ADİ    SUM(URUN_MİKTARİ) GROUP BY ISİM, URUN_MİKTARİ**
  ve bu toplam değeri 3 ve fazlası olan kayıtları toplam urun miktarlarina göre
             **HAVİNG SUM(URUN_MİKTARİ)>=3      **  ORDER BY SUM(URUN_MİKTARİ)
  ters siralayarak listeyen sorguyu yazınız.  veli elma 5
       **DESC                                 ali elma 5
                                              ali armut 4...         */
                                              
  -- AGGREGATE (toplama sum, count vs)fonksiyonları ile ilgili bir koşul koymak
   --için GROUP BY'dan sonra HAVING cümleciği kullanılır.                                            
                                              
                                              
                                            
SELECT isim, urun_adi, SUM(urun_miktari) toplam_urun FROM manav
GROUP BY isim, urun_adi
HAVING SUM(urun_miktari)>=3
ORDER BY SUM(urun_miktari) DESC;


-- ORNEK6: satılan urun_adi'na göre gruplayıp MAX urun sayılarını,(yine max ürün sayısına göre)
--  sıralayarak listeyen sorguyu yazınız. NOT: Sorgu, sadece MAKS urun_miktari
--  MIN urun_miktarına eşit olmayan kayıtları (where gibi koşul var) listelemelidir.
 ------------------------------------------------

SELECT urun_adi, MAX(urun_miktari) FROM manav
GROUP BY urun_adi
HAVING MAX(urun_miktari) <> MIN(urun_miktari)  -- esit degil <> = !=
ORDER BY MAX(urun_miktari);

/*
============================= DISTINCT =====================================
    DISTINCT cümleciği bir SORGU ifadesinde benzer olan satırları flitrelemek
    için kullanılır. Dolayısıyla seçilen sutun yada sutunlar için benzersiz veri
    içeren satırlar oluşturmaya yarar.
    SYNTAX
    --------------------------------------------------------
    
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_adı;    */

-- ORNEK1: satılan farklı meyve türlerinin sayısını listeyen sorguyu yazınız.
--  (kaç farklı meyve türü var, elma armut üzüm=3)

SELECT COUNT (DISTINCT urun_adi) urun_cesit_sayisi FROM manav;

-- ORNEK2: satılan meyve adi ve isimlerin (totalde) farklı olanlarını listeyen sorguyu yazınız.

SELECT DISTINCT urun_adi, isim FROM manav;

-- ORNEK3: satılan meyvelerin urun_miktarlarinin benzersiz  olanlarının
--  toplamlarini listeyen sorguyu yazınız.2+3+4+5=14

SELECT SUM (DISTINCT urun_miktari) benzersiz_urun_sayisi_toplami FROM manav;
































