

CREATE TABLE sirketler3
    (
        sirket_id NUMBER(9),
        sirket_isim VARCHAR2(20)
    );
    
    drop table siparisler;
    
    INSERT INTO sirketler3 VALUES(100, 'Toyota');
    INSERT INTO sirketler3 VALUES(101, 'Honda');
    INSERT INTO sirketler3 VALUES(102, 'Ford');
    INSERT INTO sirketler3 VALUES(103, 'Hyundai');
    
    CREATE TABLE siparisler1
    (
        siparis_id NUMBER(9),
        sirket_id NUMBER(9),
        siparis_tarihi DATE
    );
    
    INSERT INTO siparisler1 VALUES(11, 101, '17-04-2020');
    INSERT INTO siparisler1 VALUES(22, 102, '18-04-2020');
    INSERT INTO siparisler1 VALUES(33, 103, '19-04-2020');
    INSERT INTO siparisler1 VALUES(44, 104, '20-04-2020');
    INSERT INTO siparisler1 VALUES(55, 105, '21-04-2020');
    
    SELECT * FROM siparisler1;
    SELECT * FROM sirketler3;
    
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
    select sirket_isim, siparis_id, siparis_tarihi, sp.siparis_id from sirketler3 s
    FULL JOIN siparisler1 sp
    ON sp.sirket_id = s.sirket_id;
   
    
--  ORNEK2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--  siparis_tarihleri listeleyen bir sorgu yaziniz. null olanlar çıkmıcak 
-- çünkü NULL ortak değil(bir tabloda null iken diğerinde id null yok, 100, 101 vs var)  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    