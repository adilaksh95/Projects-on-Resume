-- create OMDB --
-----------------
-- drop tables --
drop table albums
/ 
drop type disk_type
/ 
drop type mp3_type
/
drop type album_type
/
drop type artist_array_type
/
drop type artist_type
/
drop type review_table_type
/
drop type review_type
/
-- create types --
create or replace type artist_type as object 
(artistName 	varchar(50), 
 artistRole 	varchar(25))
/ 
create type artist_array_type  
as varray(5) of artist_type
/ 
create or replace type review_type as object 
(reviewerName 	varchar(25), 
 reviewDate   	date,
 reviewText   	varchar(250), 
 reviewScore  	number)
/
create or replace type review_table_type as table of review_type
/
create or replace type album_type as object 
(albumTitle 		varchar(50),
 albumPlaytime 		number(3), -- minutes
 albumReleaseDate 	date, 
 albumGenre 		varchar(15),
 albumPrice 		number(9,2),
 albumTracks		number(2),
 albumArtists		artist_array_type,
 albumReviews 		review_table_type,
member function discountPrice return number,
member function containsText (pString1 varchar2, pString2 varchar2) return integer)
not instantiable not final 
/
create or replace type disk_type under album_type 
( mediaType 		varchar(10),
 diskNum			number(2), -- number of disks
 diskUsedPrice 		number(9,2),
 diskDeliveryCost 	number(9,2), 
overriding member function discountPrice return number)
/
create or replace type mp3_type under album_type
(downloadSize 	number, -- size in MB
 overriding member function discountPrice return number)
/
-- create tables --
create table albums of album_type 
object id system generated
nested table albumReviews store as store_reviews 
/ 

insert into albums
values(disk_type('The Essential Bob Dylan',99,'8-Jul-2016','Pop',37.00,32,
artist_array_type(
artist_type('Bob Dylan','Composer'),
artist_type('Bob Dylan','Vocals')),
review_table_type(
review_type('Shawn','24-Jul-2018', 'Wife loved it!',5),
review_type('Reuben','2-Aug-2019', 'Great compilation of some of his most known songs',5)),
'Vinyl', 2,'',11.00))
/
insert into albums
values(disk_type('Sketches of Spain',45,'8-Mar-2011','Jazz',14.99,6,
artist_array_type(
artist_type('Miles Davis','Composer'),
artist_type('Miles Davis','Musician')),
review_table_type(
review_type('Frederick','16-Sep-2016', 'Recommend listening while viewing a sunset.',5),
review_type('Juliet','12-Mar-2018','Early days of The Great Miles--no lover of jazz should be without this album.',5)),
'Vinyl',1 ,16.29,7.00))
/
insert into albums
values(disk_type('Bob Dylans Greatest Hits',45,'31-Jan-2017','Pop Rock',29.87,10,
artist_array_type(
artist_type('Bob Dylan','Composer'),
artist_type('Bob Dylan','Vocals')),
review_table_type(
review_type('Kandy','16-Mar-2015', 'Early Dylan in all his glory.',5),
review_type('Stewart','18-Feb-2013', 'Captures Bob Dylan transformation from a folk song Composer to a rock legend',4)),
'Vinyl',1 ,'',11.00))
/
insert into albums
values(disk_type('Harvest (2009 Remaster)',44,'21-Jun-2009','Rock Country',28.50,10,
artist_array_type(
artist_type('Neil Young','Composer'),
artist_type('Neil Young','Vocals')),
review_table_type(
review_type('John','18-Feb-2019', 'I absolutely LOVE this CD!',5),
review_type('Stewart','18-Feb-2013', 'Sounds good on vinyl!',5)),
'Vinyl',1 ,14.99,11.00))
/
insert into albums
values(disk_type('Kind Of Blue (Legacy Edition)',155,'20-Jan-2009','Jazz',19.99,21,
artist_array_type(
artist_type('Miles Davis','Composer'),
artist_type('Miles Davis','Musician')),
review_table_type(
review_type('Laurence','10-Sep-2014', 'Very very special recording.',5)),
'Vinyl',3 ,16.99,10.00))
/
insert into albums
values(disk_type('Harvest (2009 Remaster)',44,'21-Jun-2009','Rock Country',10.50,10,
artist_array_type(
artist_type('Neil Young','Composer'),
artist_type('Neil Young','Vocals')),
review_table_type(
review_type('John','18-Feb-2019', 'I absolutely LOVE this CD!',5),
review_type('Anthony','16-Aug-2019', 'Neil Youngs signature album.',4)),
'Audio CD',1 ,4.99,11.00))
/
insert into albums
values(disk_type('The Essential Bob Dylan',99,'8-Jul-2016','Pop',26.17,32,
artist_array_type(
artist_type('Bob Dylan','Composer'),
artist_type('Bob Dylan','Vocals')),
review_table_type(
review_type('Christopher','24-Jun-2016', 'This is a terrific album.',5),
review_type('Cauley','2-Aug-2015', 'There can only be one Bob Dylan. God blessed him with the gift of verse.',5)),
'Audio CD',2 ,'',7.00))
/
insert into albums
values(disk_type('Bob Dylans Greatest Hits',50,'1-Jun-1999','Pop Rock',20.81,10,
artist_array_type(
artist_type('Bob Dylan','Composer'),
artist_type('Bob Dylan','Vocals')),
review_table_type(
review_type('Kandy','16-Mar-2015', 'Early Dylan in all his glory.',5),
review_type('Stewart','18-Feb-2013', 'Captures Bob Dylan transformation from a folk song composer to a rock legend.',4)),
'Audio CD ',1 ,'',7.00))
/
insert into albums
values(disk_type('Kind Of Blue (Legacy Edition)',155,'20-Jan-2009','Jazz',19.99,21,
artist_array_type(
artist_type('Miles Davis','Composer'),
artist_type('Miles Davis','Musician')),
review_table_type(
review_type('Amy','17-Apr-2018', 'Poor quality sound compared to the vinyl record.',2)),
'Audio CD',3 ,16.99,10.00))
/
insert into albums
values(disk_type('Sketches of Spain',45,'20-Jan-2009','Jazz',3.11,6,
artist_array_type(
artist_type('Miles Davis','Composer'),
artist_type('Miles Davis','Musician')),
review_table_type(
review_type('Sara','3-Oct-2016', 'Another Must Have! One of Miles finest works.',5),
review_type('Douglas','14-Jun-2014', 'You might like it, but I admit it seems like a difficult listen.',5)),
'Audio CD',1 ,6.41,7.00))
/
insert into albums
values(disk_type('Gustav Mahler Symphony No. 9',45,'12-Oct-2017','Classical',23.10,5,
artist_array_type(
artist_type('David Zinman','Conductor'),
artist_type('Gustav Mahler','Composer'),
artist_type('Tonhalle Orchestra','Orchestra')),
review_table_type(
review_type('Lindon','3-Dec-2010', 'This is an uneventful but fine recording.',3),
review_type('Prescott','24-Aug-2013', 'This is truly a spellbinding record.',5)),
'Audio CD',1,15.20,7.00))
/
insert into albums
values(mp3_type('Bob Dylans Greatest Hits',55,'1-Jan-2019','Pop Rock',5.98,10,
artist_array_type(
artist_type('Bob Dylan','Composer'),
artist_type('Bob Dylan','Vocals')),
review_table_type( 
review_type('Mandy','16-Mar-2019', 'Fantastic music!',5)),
60))
/
insert into albums
values(mp3_type('Best of Neil Young',153,'21-Feb-2019','Pop Rock',17.50,35,
artist_array_type(
artist_type('Neil Young','Composer'),
artist_type('Neil Young','Vocals')),
review_table_type( 
review_type('John','16-Apr-2019', 'Great artist and great music.',5)),
165))
/
insert into albums
values(mp3_type('Harvest (2009 Remaster)',44,'21-Jun-2009','Rock Country',9.49,10,
artist_array_type(
artist_type('Neil Young','Composer'),
artist_type('Neil Young','Vocals')),
review_table_type( 
review_type('John','16-Apr-2019', 'Great artist and great music.',5)),
52))
/
insert into albums
values(mp3_type('Sketches of Spain',45,'16-Aug-2013','Jazz',24.99,6,
artist_array_type(
artist_type('Miles Davis','Composer'),
artist_type('Miles Davis','Musician')),
review_table_type( 
review_type('Douglas','14-Jun-2014', 'You might like it but I admit it seems like a difficult listen.',5)),
51))
/
insert into albums
values(mp3_type('B.B. King Greatest Hits',114,'16-Jul-2013','Rock Blues',11.49,24,
artist_array_type(
artist_type('B.B. King','Vocals'),
artist_type('B.B. King','Guitar')),
review_table_type( 
review_type('David','18-May-2015', 'I highly recommend this album to anyone who want to see what BB King is all about.',4)),
125))
/
insert into albums
values(mp3_type('The Essential Bob Dylan',99,'8-Jul-2016','Pop',16.00,32,
artist_array_type(
artist_type('Bob Dylan','Composer'),
artist_type('Bob Dylan','Vocals')),
review_table_type( 
review_type('Christopher','24-Jun-2016', 'This is a terrific album.',5),
review_type('Cauley','2-Apr-2015', 'There can only be one Bob Dylan. God blessed him with the gift of verse',5)),
112))
/
insert into albums
values(mp3_type('Other Peoples Lives',42,'15-Feb-2019','Rock Dance',9.49,10,
artist_array_type(
artist_type('Stats','Composer'),
artist_type('Stats','Vocals')),
review_table_type( 
review_type('George','17-Sep-2019', 'Good dancing music.',3)),
45))

/

select distinct a.albumtitle,a.albumreleasedate,a.albumprice 
from albums a, table(a.albumartists) v
where v.artistname =('Neil Young') and
a.albumreleasedate>('1-Jan-2015');

/

select distinct a.albumtitle, v.artistname
from albums a, table(a.albumartists) v
where value(a) IS OF (mp3_type) order by a.albumtitle;


/

select a.albumtitle as albumtitle, min(v.reviewscore) as rev 
from albums a,table(a.albumreviews) v
where value(a)is of (mp3_type)

and v.reviewscore=(select avg(reviewscore) 
from table(a.albumreviews)
where value(a) is of (mp3_type))          

group by albumtitle having count(*)>1;

/

select distinct a.albumtitle
from albums a, albums b,albums c 
where treat (value(a) as disk_type).mediatype='Vinyl' 
and treat (value(b) as disk_type).mediatype='Audio CD'
and value(c) is of (mp3_type)
and a.albumtitle=c.albumtitle
order by a.albumtitle;

/

create or replace type body album_type as
member function discountPrice return number is
begin
    return albumPrice;
end discountPrice;
-------This part of the code needs to be modified as per the solution for Question 8---------
member function containsText (pString1 varchar2, pString2 varchar2) return integer is
Comparison integer;
begin
    Comparison:=INSTR(pString1,pString2);
    
    if Comparison>0 then
        Comparison:=1;
    else
        Comparison:=0;
    end if;
    return Comparison;
end containsText;
end;
-------This part of the code needs to be modified as per the solution for Question 8-----------
/
select a.albumtitle,v.reviewtext,v.reviewscore, a.containstext(v.reviewtext,'Great') as Great
from albums a, table(a.albumreviews) v

where a.containstext(v.reviewtext,'Great')=1;


/

create or replace type body disk_type as
overriding member function discountPrice return number is
price number;
begin
    if mediaType = 'Vinyl' and (sysdate - albumreleasedate) > 365  THEN
        price:= albumPrice*0.85;
    ELSIF mediaType = 'Audio CD' and (sysdate - albumreleasedate) > 365 THEN
        price:= albumPrice*0.8;
    ELSE
        price:= albumPrice;
    end if;
    return price;
end discountPrice;
end; 

/

create or replace type body mp3_type as
overriding member function discountPrice return number is
price number;
begin
    if (sysdate - albumreleasedate) > 730  THEN
        price:= albumPrice*0.9;
    else
        price:= albumPrice;
    end if;
    return price;
end discountPrice;
end;

/

select k.albumTitle albumTitle, 
k.albumReleaseDate albumReleaseDate, 
k.albumPrice albumPrice, 
k.discountPrice() discountPrice
from albums k


/
create view all_albums(albumtitle,mediatype,albumprice,discount)as
select distinct l.albumTitle , treat (value(l) as disk_type).mediatype, 
l.albumPrice ,l.albumprice-l.discountPrice() as discount 
from albums l where treat (value(l) as disk_type).mediatype='Vinyl'

union

select distinct m.albumTitle , treat (value(m) as disk_type).mediatype, 
m.albumPrice ,m.albumprice-m.discountPrice() as discount 
from albums m where treat (value(m) as disk_type).mediatype='Audio CD'

union

select distinct n.albumTitle, 'mp3', 
n.albumPrice ,n.albumprice-n.discountPrice() as discount 
from albums n
where value(n) is of (mp3_type);

select * from all_albums where 
discount=(select max(discount) from all_albums);

select * from all_albums;

/
drop view all_albums;
/

create view all_albums(albumtitle,mediatype,albumprice,discount,usedprice)as
select distinct l.albumTitle , treat (value(l) as disk_type).mediatype, 
l.albumPrice ,l.albumprice-l.discountPrice() as discount,
treat (value(l) as disk_type).diskusedprice 
from albums l where treat (value(l) as disk_type).mediatype='Vinyl'

union

select distinct m.albumTitle , treat (value(m) as disk_type).mediatype, 
m.albumPrice ,m.albumprice-m.discountPrice() as discount,
treat (value(m) as disk_type).diskusedprice 
from albums m where treat (value(m) as disk_type).mediatype='Audio CD'

union

select distinct n.albumTitle, 'mp3', 
n.albumPrice ,n.albumprice-n.discountPrice() as discount,0.0 
from albums n
where value(n) is of (mp3_type);

select albumtitle,mediatype,albumprice,discount,usedprice
from all_albums where 
usedprice= (select max(usedprice) from all_albums);

/
drop view all_albums;
/



--------Solution for 8------------------------------- 






