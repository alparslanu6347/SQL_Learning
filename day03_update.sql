----UPDATE  -  SET---------

/*Aşağıdaki gibi tedarikciler adında bir tablo oluşturunuz ve vergi_no
   sutununu primary key yapınız. Ayrıca aşağıdaki verileri tabloya giriniz.
   
    vergi_no NUMBER(3),
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50),
    
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
    
    Sonrasında aşağıdaki gibi urunler adında bir başka tablo oluşturunuz ve bu
    tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu
    ilişkilendiriniz. Verileri giriniz.
    
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),
    
    INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
    INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');*/
    
    
    CREATE TABLE TEDARIKCILER1(
    
    vergi_no NUMBER(3) PRIMARY KEY,
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50)   
    );

    INSERT INTO tedarikciler1 VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler1 VALUES (102, 'Huawei', 'Çin Li');
	INSERT INTO tedarikciler1 VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler1 VALUES (104, 'Apple', 'Adam Eve');
    
    CREATE TABLE URUNLER1(
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),
    CONSTRAINT urunler_fk FOREIGN KEY (ted_vergino) REFERENCES TEDARIKCILER1 (vergi_no)
    );
    
    INSERT INTO urunler1 VALUES(101, 1001,'Laptop', 'Ayşe Can');
    INSERT INTO urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler1 VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler1 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
    
    SELECT * FROM URUNLER1;
    SELECT * FROM tedarikciler1;
    
    -- SYNTAX
    ----------
    -- UPDATE tablo_adı
    -- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...
    -- WHERE koşul;

--ORNEK1: VERGI NOSU 101 OLAN TEDARIKCININ FIRMA ISMINI 'LG' OLARAK GUNCELLEYIN

UPDATE tedarikciler1 SET firma_ismi='LG'
WHERE vergi_no=101;

--ORNEK2: TEDARIKCILER TABLOSUNDAKI TUM FIRMA ISIMLERINI SAMSUNG OLARAK GUNCELLE

UPDATE tedarikciler1 SET firma_ismi='Samsung';

SELECT * FROM tedarikciler1;

--ORNEK3: vergi_no’su 102 olan tedarikcinin ismini 'Lenovo' ve irtibat_ismi’ni
-- 'Ali Veli' olarak güncelleyeniz.
    
UPDATE tedarikciler1 SET firma_ismi='Lenovo', irtibat_ismi='Ali Veli'
WHERE vergi_no=102;

SELECT * FROM tedarikciler1;
    
--ORNEK4: FIRMA ISMI SAMSUNG OLAN TEDARIKCININ IRTIBAT_ISMINI AYSE YILMAZ OLARAK GUNCELLEYIN

UPDATE tedarikciler1 SET irtibat_ismi='Ayse Yilmaz'
WHERE firma_ismi='Samsung';
    
SELECT * FROM tedarikciler1;    
    
--ornek5: urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id
-- değerlerini bir arttırınız   
    
  UPDATE urunler1 SET urun_id= urun_id+1
  WHERE urun_id>1004;
    
    SELECT * FROM urunler1;
    
--ORNEK6 : urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino
--  sutun değeri ile toplayarak güncelleyiniz. 
    
UPDATE urunler1 SET urun_id= urun_id+ted_vergino;
    
  SELECT * FROM urunler1;  
    
 --ORNEK7 : urunler tablosundan Ali Bak’in aldigi urunun ismini, TEDARİKCİ
--TABLOSUNDA İRTİBAT_İSMİ 'Adam Eve' OLAN FİRMANIN İSMİ (FİRMA_İSMİ) ile
-- degistiriniz.  
    
  UPDATE urunler1 SET urun_isim= (SELECT firma_ismi FROM tedarikciler1 
                                    WHERE irtibat_ismi='Adam Eve') 
    WHERE musteri_isim='Ali Bak';
    
    DROP TABLE TEDARIKCILER1;
    
--odev-ORNEK9: Laptop satin alan musterilerin ismini, Apple’in irtibat_isim'i ile
-- degistirin
    
    UPDATE urunler1 SET musteri_isim=(SELECT irtibat_ismi FROM tedarikciler1
                                        WHERE firma_ismi='Apple')
    WHERE urun_isim='Laptop';
    SELECT * FROM urunler1; 
    
    
    
    
    
    
    
    
    
    
    
    
    