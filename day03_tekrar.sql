CREATE TABLE ogrenciler2
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        adres VARCHAR2(100),
        sinav_notu NUMBER(3)
    );
    
    INSERT INTO ogrenciler2 VALUES(123, 'Ali Can', 'Ankara',75);
    INSERT INTO ogrenciler2 VALUES(124, 'Merve Gul', 'Ankara',85);
    INSERT INTO ogrenciler2 VALUES(125, 'Kemal Yasa', 'Istanbul',85);
    
    SELECT * FROM ogrenciler2;
    
    --ornek1: sinav notu 80 den buyuk olan tum ogrenci bilgilerini listele

SELECT * FROM ogrenciler2
WHERE sinav_notu>80;

--ornek2: adresi Ankara olan ogrencilerin isim ve adres bilgilerini listele

SELECT isim, adres FROM ogrenciler2
WHERE adres='Ankara';

--ornek3: id si 124 olan ogrencilerin tum bilgilerini sil

DELETE FROM ogrenciler2 WHERE id=124;

    SELECT * FROM ogrenciler2;
    
CREATE TABLE personel1
    (
        id CHAR(5),
        isim VARCHAR2(50),
        maas NUMBER(5)
    );
    
    INSERT INTO personel1 VALUES('10001', 'Ahmet Aslan', 7000);
    INSERT INTO personel1 VALUES( '10002', 'Mehmet Yılmaz' ,12000);
    INSERT INTO personel1 VALUES('10003', 'Meryem ', 7215);
    INSERT INTO personel1 VALUES('10004', 'Veli Han', 5000);
    INSERT INTO personel1 VALUES('10005', 'Mustafa Ali', 5500);
    INSERT INTO personel1 VALUES('10005', 'Ayşe Can', 4000);
    
    SELECT * FROM personel1;
    
    --ornek4: id si 10002 ile 10005 arasinda olan personelin bilgilerini listele

-- 1.nci yontem:

SELECT * FROM personel1
WHERE id BETWEEN '10002' AND '10005';

-- 2.nci yontem:

SELECT * FROM personel1
WHERE id>='10002' AND id<='10005';

--ornek5: ismi Mehmet Yilmaz ile Veli Han arasindaki personel bilgilerini listele

SELECT * FROM personel1
WHERE isim BETWEEN 'Mehmet Yılmaz' AND 'Veli Han';

--ornek6: id si 10002-10004 arasinda olmayan personelin ID ve maasini listele

SELECT id, maas FROM personel1
WHERE id NOT BETWEEN '10002' AND '10004';

--ornek7: maasi 4000, 5000, 7000 olan personelin bilgilerini listele

SELECT * FROM personel1 
WHERE maas IN(4000,5000,7000);

SELECT * FROM personel1 
WHERE isim IN('Veli Han','Ahmet Aslan');
    
--------------------------------------------------------------------------------
CREATE TABLE TEDARIKCILER2(
    
    vergi_no NUMBER(3) PRIMARY KEY,
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50)   
    );

    INSERT INTO tedarikciler2 VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler2 VALUES (102, 'Huawei', 'Çin Li');
	INSERT INTO tedarikciler2 VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler2 VALUES (104, 'Apple', 'Adam Eve');
    
    CREATE TABLE URUNLER3(
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),
    CONSTRAINT urunler_fkk FOREIGN KEY (ted_vergino) REFERENCES TEDARIKCILER2 (vergi_no)
    );
    
    INSERT INTO urunler3 VALUES(101, 1001,'Laptop', 'Ayşe Can');
    INSERT INTO urunler3 VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler3 VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler3 VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler3 VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler3 VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler3 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
    
    SELECT * FROM URUNLER3;
    SELECT * FROM tedarikciler2;
    
--ORNEK1: VERGI NOSU 101 OLAN TEDARIKCININ FIRMA ISMINI 'LG' OLARAK GUNCELLEYIN

UPDATE tedarikciler2 SET firma_ismi='LG'
WHERE vergi_no=101;
 SELECT * FROM tedarikciler2;

--ORNEK2: TEDARIKCILER TABLOSUNDAKI TUM FIRMA ISIMLERINI SAMSUNG OLARAK GUNCELLE

UPDATE tedarikciler2 SET firma_ismi='Samsung';
 SELECT * FROM tedarikciler2;

--ORNEK3: vergi_no’su 102 olan tedarikcinin ismini 'Lenovo' ve irtibat_ismi’ni
-- 'Ali Veli' olarak güncelleyeniz.
    
UPDATE tedarikciler2 SET firma_ismi='Lenovo', irtibat_ismi='Ali Veli'
WHERE vergi_no=102;

SELECT * FROM tedarikciler2;
    
--ORNEK4: FIRMA ISMI SAMSUNG OLAN TEDARIKCININ IRTIBAT_ISMINI AYSE YILMAZ OLARAK GUNCELLEYIN

 UPDATE tedarikciler2 SET irtibat_ismi='Ayse Yilmaz'
 WHERE firma_ismi='Samsung';
 
 SELECT * FROM tedarikciler2;
    
--ornek5: urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id
-- değerlerini bir arttırınız   
    
 UPDATE urunler3 SET urun_id=urun_id+1
 WHERE urun_id>1004;
 
 SELECT * FROM URUNLER3;
    
--ORNEK6 : urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino
--  sutun değeri ile toplayarak güncelleyiniz. 
    
UPDATE urunler3 SET urun_id=urun_id+ted_vergino;

SELECT * FROM URUNLER3;
    
--ORNEK7 : urunler tablosundan Ali Bak’in aldigi urunun ismini, TEDARİKCİ
--TABLOSUNDA İRTİBAT_İSMİ 'Adam Eve' OLAN FİRMANIN İSMİ (FİRMA_İSMİ) ile
-- degistiriniz.  
    
 UPDATE urunler3 SET urun_isim= (SELECT firma_ismi FROM tedarikciler1 
                                    WHERE irtibat_ismi='Adam Eve') 
    WHERE musteri_isim='Ali Bak';
  
  SELECT * FROM URUNLER3;
    
--odev-ORNEK9: Laptop satin alan musterilerin ismini, Apple’in irtibat_isim'i ile
-- degistirin
    
  UPDATE urunler3 SET musteri_isim=(SELECT irtibat_ismi FROM tedarikciler1
                                    where irtibat_ismi='Apple')
  WHERE urun_isim='Laptop';
    
    
    
    
    
    
    
    
    
    
    
    
    