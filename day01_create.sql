--TABLO OLUSTURMA-----
CREATE TABLE student
(
id CHAR(4),
name VARCHAR(20),
age NUMBER

);


--VERI GIRISI----
INSERT INTO student VALUES('1001','MEHMET ALA', 25);
INSERT INTO student VALUES('1002','AYSE',12);

--TABLO VERI SORGULAMA---
SELECT * FROM student;

--TABLO SILME---
DROP TABLE student;

--parcali veri girisi---
INSERT INTO student(id,name) VALUES('1003','FATMA');

--VERI TABANINIZDA URUNLER ADINDA BIR TABLO OLUSTURUN----
-- urun_id=> number
-- urun_adi=> VARCHAR(50)
-- fiyat => number
-- (100, cips, 5)
-- (200,kola,6)

CREATE TABLE urunler(
urun_id NUMBER,
urun_name VARCHAR(50),
fiyat NUMBER
);

INSERT INTO urunler VALUES('100','cips',5);
INSERT INTO urunler VALUES('200','kola',6);

SELECT * FROM urunler;