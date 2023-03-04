/*=============================== ALTER TABLE ==================================
    
    ALTER TABLE  tabloda ADD, MODIFY, veya DROP/DELETE COLUMNS islemleri icin 
    kullanilir.
    
    ALTER TABLE ifadesi tablolari yeniden isimlendirmek (RENAME) icin de
    kullanilir.
   
==============================================================================*/

    CREATE TABLE personel8 
    (
        id NUMBER(9), 
        isim VARCHAR2(50), 
        sehir VARCHAR2(50), 
        maas NUMBER(20), 
        sirket VARCHAR2(20),
        CONSTRAINT personel_pk2 PRIMARY KEY (id)
    );


    INSERT INTO personel8 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel8 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel8 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
    INSERT INTO personel8 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel8 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel8 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
  
    
      
/* -----------------------------------------------------------------------------
  ORNEK1: personel tablosuna ulke_isim adinda ve default degeri 'Turkiye' olan 
  yeni bir sutun ekleyiniz.
------------------------------------------------------------------------------*/ 
    
    ALTER TABLE personel8
    ADD ulke_isim VARCHAR2(20) DEFAULT 'TURKIYE';
    
    select * from personel8;
    
      
/* -----------------------------------------------------------------------------
  ORNEK2: personel tablosuna cinsiyet Varchar2(20) ve yas Number(3) seklinde 
  yeni sutunlar ekleyiniz.
------------------------------------------------------------------------------*/  
    ALTER TABLE personel8
    ADD (cinsiyet VARCHAR2(7), yas NUMBER(3)); -- ayri ayri 2 tane add ile de ekleyebiliriz.
    
     ALTER TABLE personel8
    ADD cinsiyet2 VARCHAR2(7) 
    ADD yas2 NUMBER(3);
    
    
    select * from personel8;
/* -----------------------------------------------------------------------------
  ORNEK3: personel tablosundan yas sutununu siliniz. 
------------------------------------------------------------------------------*/ 

    ALTER TABLE personel8
    DROP COLUMN yas2;
    
    select * from personel8;
/* -----------------------------------------------------------------------------
  ORNEK4: personel tablosundaki ulke_isim sutununun adini ulke_adi olarak 
  degistiriniz. 
------------------------------------------------------------------------------*/  
    ALTER TABLE personel8
    RENAME COLUMN ulke_isim TO ulke_adi;
    
   select * from personel8;
/* -----------------------------------------------------------------------------
  ORNEK5: personel tablosunun adini isciler olarak degistiriniz. 
------------------------------------------------------------------------------*/  
    ALTER TABLE personel8
    RENAME TO isciler; -- Artik boyle cagiririz, personel8 tablosu da drop olmus olur.
  
    select * from isciler;
    
/* -----------------------------------------------------------------------------
  ORNEK6: isciler tablosundaki ulke_adi sutununa NOT NULL kisitlamasi ekleyiniz. 
------------------------------------------------------------------------------*/ 
    ALTER TABLE isciler
    MODIFY ulke_adi VARCHAR2(30) NOT NULL; -- Hem veri tipini degistirik hem de 
                                           -- NOT NULL kisitlamasi ekledik.
    -- maasi unique yap
    ALTER TABLE isciler
    MODIFY maas UNIQUE; -- TEKRARLI MAASLAR (2 TANE 4500 VAR) OLDUGU ICIN UNIQUE MODIFY YAPMAYIZ
    
    
    ALTER TABLE isciler
    MODIFY isim CHAR(100) ;     -- Veritipini CHAR(100) olarak degistirdik.
    
    --CHECK kisitlamasini ekleyelim
    ALTER TABLE isciler
    MODIFY maas CHECK (maas >= 3500);   -- Maas alt limit kisitlamasi atadik.3500 den az maas giremeyiz.
   
    INSERT INTO isciler VALUES(123452310, 'Hatice Sahin', 'Bursa', 4000,'Ford', 'Almanya', 'Kadin',35, 'Kadin');
    
    
    
    
    
    
    
    