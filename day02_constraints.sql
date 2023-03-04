/*======================= CONSTRAINTS - KISITLAMALAR ======================================

NOT NULL - Bir sutunun NULL icermesini garanti eder.

UNIQUE - Bir sutundaki tum degerlerin BENZERSİZ olmasini garanti eder. Null
         kabul eder, hatta birden fazla null deger girilebilir.

PRIMARY KEY - Bir sutunun NULL icermemesini ve sutundaki verilerin BENZERSİZ 
              olmasini garanti eder. (NOT NULL ve UNIQUE birlesimi gibi)
              
FOREIGN KEY - Baska bir tablodaki Primary Key' i referans gostermek icin
              kullanilir. Boylelikle arasinda iliski kurulmus olur.
              
CHECK - Bir sutundaki tum verilerin belirlenen ozel bir sarti saglamasini
        garanti eder. Soldan tablo silerken kapali olmasi lazim */
        
--ORNEK1-----NOT NULL
-- ogrenciler tablosu olusturalim ve id field ini bos birakilmaz yapalim.

CREATE TABLE ogrenciler(
id char(4) not null,
isim varchar(50),
not_ort number(4,2), -- 98,55 gibi not demek
kayit_tarihi date
);

INSERT INTO ogrenciler VALUES ('1234','hasan', 75.25, '14-01-2020');
INSERT INTO ogrenciler VALUES ('1234','ayse', null, null);
INSERT INTO ogrenciler (id, isim) VALUES('3456','fatma');
INSERT INTO ogrenciler VALUES (null,'osman', 45.25, '5-01-2020');

SELECT * FROM ogrenciler;


--ORNEK2 UNIQUE
--tedarikciler olusturalim id unique olsun

CREATE TABLE tedarikciler(
id char(4) UNIQUE,
isim varchar(50),
adres varchar(100),
tarih date

);

INSERT INTO tedarikciler VALUES('1234','ayse', 'mehmet mah izmir','10-11-2020');
INSERT INTO tedarikciler VALUES('1234','FATMA', 'veli mah istanbul','5-11-2020');--id ayni oldugu icin hata veriyor
INSERT INTO tedarikciler VALUES(null,'cem', 'suvari mah denizli','5-11-1997');
INSERT INTO tedarikciler VALUES(null,'can', 'zeki mah mus','5-11-1998');
-- unique constraints tekrar izin vermez ancak istedigimiz kadar null girebilirsiniz.

SELECT * FROM tedarikciler;

--ORNEK3-----
CREATE TABLE personel(
id char(5) PRIMARY KEY,
isim varchar(50)UNIQUE,
maas NUMBER(5) NOT NULL,
ise_baslama DATE

);

    INSERT INTO personel VALUES('10001', 'Ahmet Aslan',7000, '13-04-2018');
    INSERT INTO personel VALUES( '10001', 'Mehmet Yılmaz' ,12000, '14-04-18');--HATA ALIR
    INSERT INTO personel VALUES('10003', '', 5000, '14-04-18');
    INSERT INTO personel VALUES('10004', 'Veli Han', 5000, '14-04-18');
    INSERT INTO personel VALUES('10005', 'Ahmet Aslan', 5000, '14-04-18');--HATA ALIR
    INSERT INTO personel VALUES(NULL, 'Canan Yaş', NULL, '12-04-19');-- null olmaz

SELECT * FROM personel;


-------   -- ogrenciler3 tablosu olusturalim ve ogrenci_id 'yi PRIMARY KEY yapalim
    CREATE TABLE ogrenciler3
(
ogrenci_id char(4) PRIMARY KEY,
Isim_soyisim varchar2(50),
not_ort number(5,2), --100,00
kayit_tarihi date -- 14-01-2021
);
SELECT * FROM ogrenciler3;

INSERT INTO ogrenciler3 VALUES ('1234', 'hasan yaman',75.70,'14-01-2020');
INSERT INTO ogrenciler3 VALUES (null, 'veli yaman',85.70,'14-01-2020'); -- id null olamaz
INSERT INTO ogrenciler3 VALUES ('1234', 'Ali Can',55.70,'14-06-2020'); -- id benzersiz olmalı, daha önce verilen id kullanılamaz
INSERT INTO ogrenciler3 (isim_soyisim) VALUES ( 'Veli Cem'); -- id vermeden başka şeyler vermeye geçemezsin, default null atar, buda primary ye uymaz
INSERT INTO ogrenciler3 (ogrenci_id) VALUES ( '5687');

--primary key alternatif yontem
--bu yontemde kisitlamaya istedigimiz ismi atayabiliriz.

CREATE TABLE calisanlar(
id char(5),--primary key
isim varchar(50) UNIQUE,
maas number(5) NOT NULL,
CONSTRAINT id_primary PRIMARY KEY(id)
);

INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan',7000);
    INSERT INTO calisanlar VALUES( '10002', 'Mehmet Yılmaz' ,12000);
    INSERT INTO calisanlar VALUES('10003', 'CAN', 5000);

-- bir tabloya data eklerken constraint lere dikkat edilmelidir.

-- ornek4 foreign key

CREATE TABLE adresler(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(15),
CONSTRAINT id_foreign FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10001','Mutlu Sok', '40.Cad.','IST');
    INSERT INTO adresler VALUES('10001','Can Sok', '50.Cad.','Ankara');
    INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Ağa Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Ağa Sok', '30.Cad.','Antep');
    
    INSERT INTO adresler VALUES('10004','Gel Sok', '60.Cad.','Van');--parent da olmayan id li veriyi (10004) giremeyiz

SELECT * FROM calisanlar;--parent
SELECT * FROM adresler;--child

DROP TABLE calisanlar; --child silinmeden parent silinmez
DROP TABLE adresler;
--PRIMARY KEY 1 TANE OLUR TABLODA


-- ogrenciler5 tablosunu olusturun ve id, isim hanelerinin birlesimini primary key yapin
CREATE TABLE ogrenciler5(
ID CHAR(4),
ISIM VARCHAR(20),
NOT_ORT NUMBER(5,2),
KAYIT_TARIHI DATE,
CONSTRAINT ogrenciler5_PRIMARY PRIMARY KEY (ID,ISIM)
);

INSERT INTO ogrenciler5 VALUES (null,'Veli Cem',90.6,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ID")
INSERT INTO ogrenciler5 VALUES (1234,null,90.6,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ISIM")
INSERT INTO ogrenciler5 VALUES (1234,'Ali Can',90.6,'15-05-2019'); -- PK= 1234Ali Can
INSERT INTO ogrenciler5 VALUES (1234,'Veli Cem',90.6,'15-05-2019'); -- PK=1234Veli Cem
INSERT INTO ogrenciler5 VALUES (1234,'Oli Can',90.6,'15-05-2019');-- PK=1234Oli Can

SELECT * FROM ogrenciler5;


--“tedarikciler4” isimli bir Tablo olusturun. Icinde “tedarikci_id”, “tedarikci_isim”, “iletisim_isim” field’lari olsun.
--“tedarikci_id” ve “tedarikci_isim” fieldlarini birlestirerek Primary Key olusturun.
--“urunler2” isminde baska bir tablo olusturun.Icinde “tedarikci_id” ve “urun_id” fieldlari olsun.
--“tedarikci_id” ve “urun_id” fieldlarini birlestirerek Foreign Key olusturun

CREATE TABLE tedarikciler4(
tedarikci_id char(4),
tedarikci_isim varchar(20),
iletisim_ismi varchar(20),
CONSTRAINT tedarikciler4_pk PRIMARY KEY(tedarikci_id, tedarikci_isim)--char + varchar, parent

);

CREATE TABLE urunler2(
tedarikci_id char(4),
urun_id varchar(5),
yas number,
CONSTRAINT urunler2_fk FOREIGN KEY(tedarikci_id, urun_id) REFERENCES tedarikciler4 --char+varchar, child

);

SELECT * FROM tedarikciler4;

CREATE TABLE sehirler2 (	
    alan_kodu CHAR(3 ),
	isim VARCHAR2(50),
	nufus NUMBER(8,0) CHECK (nufus>1000)
    );
    
    INSERT INTO sehirler2 VALUES ('312','Ankara',5750000);
    INSERT INTO sehirler2 VALUES ('232','izmir',375); -- ORA-02290: check constraint (HR.SYS_C007028) violated
    INSERT INTO sehirler2 VALUES ('232','izmir',3750000);
    INSERT INTO sehirler2 VALUES ('436','Maras',null);

SELECT * FROM sehirler2;














