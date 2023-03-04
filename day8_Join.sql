

/*
============================== JOIN İSLEMLERİ ===============================
    foreıgn key id si ortakları yanyana yazıyordu bu bikaç tablodan istenilen
    sütunları alır birleştirir. set istenilen sütunları tek sütunda birleştirir
    
    Set Operatorleri (Union,Intersect,Minus) farklı tablolardaki sutunlari
    birlestirmek için de kullanilir.
    
    Join islemleri ise farklı Tablolari birlestirmek icin kullanilir. Diger
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo
    olusturmak icin kullanilabilir.

    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek
    icin JOIN islemleri kullanilabilir.
    
    ORACLE SQL'de 4 Cesit Join islemi kullanilabilmektedir.
    
    1) FULL JOIN:  Tablodaki tum sonuclari gosterir
    2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
    4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir---*/
    
    CREATE TABLE sirketler2
    (
        sirket_id NUMBER(9),
        sirket_isim VARCHAR2(20)
    );
    
    drop table siparisler;
    
    INSERT INTO sirketler2 VALUES(100, 'Toyota');
    INSERT INTO sirketler2 VALUES(101, 'Honda');
    INSERT INTO sirketler2 VALUES(102, 'Ford');
    INSERT INTO sirketler2 VALUES(103, 'Hyundai');
    
    CREATE TABLE siparisler
    (
        siparis_id NUMBER(9),
        sirket_id NUMBER(9),
        siparis_tarihi DATE
    );
    
    INSERT INTO siparisler VALUES(11, 101, '17-04-2020');
    INSERT INTO siparisler VALUES(22, 102, '18-04-2020');
    INSERT INTO siparisler VALUES(33, 103, '19-04-2020');
    INSERT INTO siparisler VALUES(44, 104, '20-04-2020');
    INSERT INTO siparisler VALUES(55, 105, '21-04-2020');
    
    SELECT * FROM siparisler;
    SELECT * FROM sirketler2;
    
/*=============================== FULL JOIN  ==================================
    FULL JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari
    getirmek icin kullanilir. ortaklar aynı satırda yazılır, extra fazla satır varsa o da yazılır.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    FULL JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK1: sirketler ve siparisler adındaki tablolarda yer alan sirket_isim,
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
    
    select sirket_isim, siparis_id, siparis_tarihi, sp.sirket_id 
    from sirketler2 s
    FULL JOIN siparisler sp
    ON sp.sirket_id=s.sirket_id;
    
-- FULL Join'de iki tabloda var olan tum satirlar gosterilir.
    -- Bir olupda digerlerine olmayan alanlar bos birakildi.
    -- Join isleminde genelde iki tablodaki ortak olarak bulunan sutun, ON 
    -- cumleciginde kosul yapisi kullanilir.
    
    
      
 /*=============================== INNER JOIN  ==================================
    
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/  
    
  
/* -----------------------------------------------------------------------------
  ORNEK2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve 
  siparis_tarihleri listeleyen bir sorgu yaziniz.null olanlar cikmayacak, 
  cunku null ortak degil
------------------------------------------------------------------------------*/  
    
    SELECT s.sirket_isim, sp.siparis_id, siparis_tarihi, sp.sirket_id
    FROM sirketler2 s
    INNER JOIN siparisler sp
    ON s.sirket_id = sp.sirket_id;
    
    -- INNER JOIN ile sadece iki tabloki ortak olan satilar secilir.
    -- Diger ifadeyle iki tablodaki ortak olan sirket_id degerleri icin ilgili 
    -- sutunlar listenir.
    
    -- INNER anahtar kelimesi opsiyoneldir.
    
        
/*=============================== LEFT JOIN  ==================================
    
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
    kimi patron yapmak istiyorsak onun tablosunu uste yazariz ve left olur.
==============================================================================*/  
            
/* -----------------------------------------------------------------------------
  ORNEK3: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz. 
  sirketler tablosu patron olacak ve o tablo left olur.
------------------------------------------------------------------------------*/   
    
    SELECT s.sirket_isim, sp.siparis_id, sp.siparis_tarihi, sp.sirket_id, s.sirket_id
    FROM sirketler2 s
    LEFT JOIN siparisler sp
    ON s.sirket_id = sp.sirket_id;
    
    SELECT sirket_isim, siparis_id, siparis_tarihi --id‘ler opsiyonel, istersek yazdiririz.
    FROM sirketler2 s
    LEFT JOIN siparisler sp
    ON s.sirket_id = sp.sirket_id;
    
    -- Left Join’de ilk tablodaki tum satirlar gosterilir.
    -- Ilk tablodaki satirlara 2.tablodan kosula uyan ortak satirlar gosterilir
    -- ancak ortak olmayan kisimlar bos kalir
          
/*=============================== RIGHT JOIN  ==================================
    
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/   
      
/* -----------------------------------------------------------------------------
  ORNEK4: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile 
  bunlara karşılık gelen sirket_isimlerini listeleyen bir sorgu yaziniz. 
  siparisler tablosu patron olacak.
------------------------------------------------------------------------------*/   
     
    SELECT siparis_id, siparis_tarihi, sirket_isim, s.sirket_id, sp.sirket_id
    FROM sirketler2 s
    RIGHT JOIN siparisler sp
    ON sp.sirket_id = s.sirket_id;
    
    SELECT s.sirket_isim, sp.siparis_id, sp.siparis_tarihi
    FROM sirketler2 s
    RIGHT JOIN siparisler sp
    ON s.sirket_id = sp.sirket_id;
    
    -- Right Join’de 2. tablodaki tum satirlar gosterilir.
    -- 2 tablodaki satirlara 1.tablodan kosula uyan ortak satirlar gosterilir
    -- ancak ortak olmayan kisimlar bos kalirir.
    
    
    	CREATE TABLE bolumler (
      bolum_id   NUMBER(2) CONSTRAINT bolum_pk PRIMARY KEY,
      bolum_isim VARCHAR2(14),
      konum      VARCHAR2(13)
    );
    
    INSERT INTO bolumler VALUES (10,'MUHASEBE','IST');
    INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
    INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
    INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
    INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');
    
    DROP table bolumler;

    CREATE TABLE personel7 (
      personel_id   NUMBER(4) CONSTRAINT personel_pk PRIMARY KEY,
      personel_isim VARCHAR2(10),
      meslek        VARCHAR2(9),
      mudur_id      NUMBER(4),
      ise_baslama   DATE,
      maas          NUMBER(7,2),
      bolum_id      NUMBER(2) 
    );
    
   SELECT * FROM bolumler;
  
    INSERT INTO personel7 VALUES (7369,'AHMET','KATIP',7902,'17-12-1980',800,20);
    INSERT INTO personel7 VALUES (7499,'BAHATTIN','SATIS',7698,'20-2-1981',1600,30);
    INSERT INTO personel7 VALUES (7521,'NESE','SATIS',7698,'22-2-1981',1250,30);
    INSERT INTO personel7 VALUES (7566,'MUZAFFER','MUDUR',7839,'2-4-1981',2975,20);
    INSERT INTO personel7 VALUES (7654,'MUHAMMET','SATIS',7698,'28-9-1981',1250,30);
    INSERT INTO personel7 VALUES (7698,'EMINE','MUDUR',7839,'1-5-1981',2850,30);
    INSERT INTO personel7 VALUES (7782,'HARUN','MUDUR',7839,'9-6-1981', 2450,10);
    INSERT INTO personel7 VALUES (7788,'MESUT','ANALIST',7566,'13-07-87',3000,20);
    INSERT INTO personel7 VALUES (7839,'SEHER','BASKAN',NULL,'17-11-1981',5000,10);
    INSERT INTO personel7 VALUES (7844,'DUYGU','SATIS',7698,'8-9-1981',1500,30);
    INSERT INTO personel7 VALUES (7876,'ALI','KATIP',7788,'13-07-87',1100,20);
    INSERT INTO personel7 VALUES (7900,'MERVE','KATIP',7698,'3-12-1981',950,30);
    INSERT INTO personel7 VALUES (7902,'NAZLI','ANALIST',7566,'3-12-1981',3000,20);
    INSERT INTO personel7 VALUES (7934,'EBRU','KATIP',7782,'23-1-1982',1300,10);
    INSERT INTO personel7 VALUES (7956,'SIBEL','MIMAR',7782,'29-1-1991',3300,60);
    INSERT INTO personel7 VALUES (7933,'ZEKI','MUHENDIS',7782,'26-1-1987',4300,60);
     
     commit;
     
    SELECT * FROM personel7;
    
    commit;

 /* -----------------------------------------------------------------------------
  ORNEK1: SATIS ve MUHASEBE bolumlerinde calisan personelin isimlerini ve 
  bolumlerini, once bolum sonra isim sıralı olarak listeleyiniz.
------------------------------------------------------------------------------*/ 

	SELECT P.personel_isim, B.bolum_isim 
	FROM bolumler B 
	FULL JOIN personel7 P 
	ON B.bolum_id = P.bolum_id
	WHERE B.bolum_id IN(10,30)
	ORDER BY B.bolum_isim, p.personel_isim;
    
    SELECT personel_isim, bolum_isim 
	FROM personel7 P 
	FULL JOIN bolumler B 
	ON B.bolum_id = P.bolum_id
	WHERE bolum_isim IN('SATIS', 'MUHASEBE')
	ORDER BY B.bolum_isim, p.personel_isim;

  
/* -----------------------------------------------------------------------------
  ORNEK2: SATIS,ISLETME ve DEPO bolumlerinde calisan personelin isimlerini,  
  bolumlerini ve ise_baslama tarihlerini isim sıralı olarak listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/  

	 SELECT bolum_isim, personel_isim, ise_baslama
	 FROM bolumler B
	 LEFT JOIN personel7 P
	 ON P.bolum_id=B.bolum_id
	 WHERE bolum_isim IN ('SATIS','ISLETME', 'DEPO') --bolum_id IN(30,40,50)
	 ORDER BY bolum_isim;

/* -----------------------------------------------------------------------------
  ORNEK3: Tüm bolumlerde calisan personelin isimlerini, bolum isimlerini ve 
  maaslarini bolum ve maas siraali listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/  

    SELECT bolum_isim, personel_isim, maas, b.bolum_id
    FROM   bolumler b
    LEFT JOIN  personel7 p
    ON  p.bolum_id = b.bolum_id
    ORDER BY b.bolum_id, maas DESC;

/* -----------------------------------------------------------------------------
  ORNEK4: SATIS ve MUDURLUK bolumlerinde calisan personelin maaslari 2000'den 
  buyuk olanlarinin isim,bolum ve maas bilgilerini bolume ve isme gore
  siralayarak listeleyiniz.
------------------------------------------------------------------------------*/   
    SELECT b.bolum_isim, p.personel_isim, p.maas 
    FROM bolumler b
    JOIN personel7 p 
    ON b.bolum_id = p.bolum_id AND p.maas >= 2000
    WHERE  b.bolum_id IN(20,30) 
    ORDER BY b.bolum_id,p.personel_isim;
 
/* -----------------------------------------------------------------------------
  ORNEK5: MUDUR'u Mesut veya Emine olan personelin bolumlerini,isimlerini,  
  maaslarini ve mudur isimlerini maas siralı olarak (Çoktan aza) listeleyiniz.
------------------------------------------------------------------------------*/   

    SELECT b.bolum_isim, p.personel_isim,p.maas, 
                    (SELECT personel_isim FROM personel7 
                     WHERE  personel_id = p.mudur_id) as mudur_adi 
    FROM bolumler b
    JOIN personel7 p 
    ON b.bolum_id = p.bolum_id
    WHERE  p.mudur_id IN(7788,7698) 
    ORDER BY p.maas DESC;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    