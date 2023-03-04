-- ============================== DELETE ===================================
    -- DELETE FROM tablo_adı;  Tablonun tüm içeriğini siler.
    -- Bu komut bir DML komutudur. Dolayısıyla devamında WHERE gibi cümlecikler
    -- kullanılabilir.
    -- DELETE FROM tablo_adı
    -- WHERE sutun_adi = veri;
    CREATE TABLE ogrenciler1
    (
        id CHAR(3),
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3)
    );
    
    INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO ogrenciler1 VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO ogrenciler1 VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrenciler1 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
	INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
  
  SAVEPOINT ABC; --ROLLBACK kısmında açıklaması var
    
    SELECT * FROM ogrenciler1;
    
    DROP TABLE ogrenciler1;
/* =============================================================================
         Seçerek silmek için WHERE Anahtar kelimesi kullanılabilir.
===============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler1
      WHERE id = 124;
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan satırını siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler1
      WHERE isim = 'Kemal Yasa';
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz ve Mustafa Bak olan kayıtları silelim.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler1
      WHERE isim = 'Nesibe Yilmaz' OR isim = 'Mustafa Bak';
/* ----------------------------------------------------------------------------
  ORNEK4: İsmi Ali Can ve id'si 123 olan kaydı siliniz.
 -----------------------------------------------------------------------------*/
     DELETE FROM ogrenciler1
     WHERE isim = 'Ali Can' AND id = 123;
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan büyük olan kayıtları silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler1
    WHERE id>126;
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 ve 126 olanları silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler1
    WHERE id IN(123,125,126);
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAKİ TÜM KAYITLARI SİLELİM..
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler1;
--*************************************************
      -- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir
/* ======================== DELETE - TRUCATE - DROP ============================
  1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.
    Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML değil DDL komutudur.*/
         TRUNCATE TABLE ogrenciler1;  --doğru yazım
   /* 2-) DELETE komutu beraberinde WHERE cümleciği kullanılabilir. TRUNCATE ile
    kullanılmaz.
        TRUNCATE TABLE ogrenciler.....yanlış yazım
        WHERE veli_isim='Hasan';
-- TRUNCATE komutu tablo yapısını değiştirmeden,
-- tablo içinde yer alan tüm verileri tek komutla silmenizi sağlar.
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylıkla geri
    alınabilir.
    4-) Truncate ile silinen veriler geri alınması daha zordur. Ancak
    Transaction yöntemi ile geri alınması mümkün olabilir.
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da
    siler. Silinen tablo Veritabanının geri dönüşüm kutusuna gider. Silinen
    tablo aşağıdaki komut ile geri alınabilir. Veya SQL GUI'den geri alınabilir.
     FLASHBACK TABLE tablo_adı TO BEFORE DROP;  -> tabloyu geri alır.
     PURGE TABLE tablo_adı;        -> Geri dönüşümdeki tabloyu siler.
     DROP TABLE tablo_adı PURGE;  -> Tabloyu tamamen siler
connections da table ı sağ tıkla =>table=>drop, purge işaretle, çöp kutusuna
atılmaksızın direk siler.
connections recyle bin sağ tıkla, purge=>tabloyu tamamen siler. flashback=>
tabloyu geri getirir
==============================================================================*/
    --INSERT veri girişinden sonra SAVEPOİNT ABC; ile verileri buraya sakla
    --(yanlışlık yapma olasılığına karşın önlem gibi, AYNI İSİMDE BAŞKA TABLO VARSA)
    --sonra istediğini sil (ister tümü ister bir kısmı)
    --sonra savepoint yaptığın yerden alttaki gibi rollback ile verileri geri getir
    drop table ogrenciler1;  --table in tamamini siler
    DELETE FROM ogrenciler1;  -- Tüm verileri sil.
    ROLLBACK TO ABC;         -- Silinen Verileri geri getir.
    SELECT * FROM ogrencıler1;
    DROP TABLE ogrenciler1;   -- Tabloyu siler ve Veritabanının Çöp kutusuna
                             -- gönderir. (DDL komutudur.)
    -- Çöp kutusundaki tabloyu geri getirir.
    FLASHBACK TABLE ogrenciler TO BEFORE DROP;
    -- Tabloyu tamamen siler (Çöp kutusuna atmaz.)
    DROP TABLE ogrenciler1 PURGE;
    -- PURGE sadece DROP ile silinmis tablolar icin kullanilir
    -- DROP kullanmadan PURGE komutu kullanmak isterseniz
    -- ORA-38302: invalid PURGE option hatasi alirsiniz
    -- Tüm veriler hassas bir şekilde siler.rollback ile geri alınamaz
    -- PURGE yapmak icin 2 yontem kullanabiliriz
--1 tek satirda DROP ve PURGE beraber kullanabiliriz
DROP TABLE ogrenciler7 PURGE;
-- bu komut ile sildigimiz tabloyu geri getirmek icin FLASHBACK komutunu kullansak
-- ORA-38305: object not in RECYCLE BIN hatasini alirsiniz
-- 2 daha once DROP ile silinmis bir tablo varsa sadece PURGE kullanabiliriz
--Tabloyu yeniden olusturalim
DROP TABLE ogrenciler7;
-- bu asamada istersek FLASHBACK ile tablomuzu geri getirebiliriz
PURGE TABLE ogrenciler7;
-- bu asamada istesem de tabloyu geri getiremem
/* =============================================================================
    Tablolar arasında ilişki var ise veriler nasıl silinebilir?
============================================================================= */
/*============================== ON DELETE CASCADE =============================
  Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme özelliğini aktif hale getirebiliriz.
  Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmak yeterli
==============================================================================*/
    CREATE TABLE talebeler
    (
        id CHAR(3),  --PK
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3),
        CONSTRAINT talebe_pk PRIMARY KEY (id)
    );
    
    INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
	INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
   
     CREATE TABLE notlar
    (
        talebe_id char(3), --FK
        ders_adi varchar2(30),
        yazili_notu number (3),
        CONSTRAINT notlar_fk FOREIGN KEY (talebe_id)
        REFERENCES talebeler(id) ON DELETE CASCADE --on delete cascade sayesinde
       --parent taki silinen bir kayıt ile ilişkili olan tüm child kayıtlarını
       --siler.  DELETE FROM talebeleR WHERE id = 124; yaparsak child daki 124 lerde silinir.
       --mesela bir hastane silindi o hastanedeki bütün kayıtlar silinmeli, oda böyle olur.
       --cascade yoksa önce child temizlenir sonra parent
    );
    
    INSERT INTO notlar VALUES ('123','kimya',75);
    INSERT INTO notlar VALUES ('124', 'fizik',65);
    INSERT INTO notlar VALUES ('125', 'tarih',90);
	INSERT INTO notlar VALUES ('126', 'Matematik',90);
    SELECT * FROM TALEBELER;
    SELECT * FROM NOTLAR;
    
    DELETE FROM notlar
    WHERE talebe_id = 124;
    
    DELETE FROM talebeler
    WHERE id = 124;
    
    -- ODEVVVV
    -- sirket id, sirket ismi, sirketteki min maas, sirketteki max maas, sirketteki ort.maas lari yazdirin
    -- izmir,istanbul veya bursada personeli bulunan sirketlerin calisan sayilarini listeleyin
    -- izmirde calisan Veli YIlmaz'in maasini 2000 yapin
    -- personel sayisi 10000 olan sirketten personel  tablosunda bulunan kisinin maasini 6000 yapin
    
    
    
    
    
    
    
    
    
    
    
    
    