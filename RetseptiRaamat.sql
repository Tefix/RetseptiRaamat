create database RetseptiRaamat
use RetseptiRaamat

create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50) not null,
email varchar (150));
select * from kasutaja
insert into kasutaja(eesnimi,perenimi,email)
values ('Roman','Zaitsev', '68421@gmail.com'),('Mark','Jurgen', 'MArkJurgen@gmail.com'),('Martin','Ligma', 'MartinLoh@gmail.com'),('Hussein','HzZabil', 'Husseinchikboi@gmail.com'),('nikita','Z', 'NikitaZetka@gmail.com');

create table kategooria(
kategooria_id int primary key identity(1,1),
kategoria_nimi varchar(50));

insert into kategooria(kategoria_nimi)
values ('soe'),('suppid'),('Road'),('chees')
select * from kategooria

create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_name varchar(100))

insert into toiduaine(toiduaine_name)
values('piim'),('juust'),('munad'),('sugar'),('sool')
select * from toiduaine

create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100))

insert into yhik(yhik_nimi)
values('ml'),('g'),('kg'),('sl'),('tl');

create table retsept(
retsept_id int primary key identity(1,1),
retsepti_nimi varchar (200),
kirjeldus varchar(200),
juhend varchar(500),
sisetatud_kp date,
kasutaja_id int,
foreign key (kasutaja_id) references kasutaja(kasutaja_id),
kategoria_id int,
foreign key (kategoria_id) references kategooria(kategooria_id));
select * from kasutaja
insert into retsept(retsepti_nimi,kirjeldus,juhend,sisetatud_kp,kasutaja_id,kategoria_id)
values
('kohupiim meega', 'kohupiim, mee', 'sega kõike', '2025-03-03', 3, 3)
select * from kategooria


create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
retsept_retsept_id int
foreign key (retsept_retsept_id) references retsept(retsept_id),
toiduaine_id int
foreign key (toiduaine_id) references toiduaine(toiduaine_id),
yhik_id int
foreign key (yhik_id) references yhik(yhik_id));
insert into koostis(kogus,retsept_retsept_id,toiduaine_id,yhik_id)
values(2, 2, 1, 1), (3, 3, 2, 2), (6, 1, 3, 3);
 
create table tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int,
foreign key (retsept_id) references retsept(retsept_id));

insert into tehtud(tehtud_kp, retsept_id)
values('2025-03-12',1),('2025-03-12',2),('2025-03-12',3)

-------------------------
retsepti_nimi,kirjeldus,juhend,sisetatud_kp,kasutaja_id,kategoria_id
----------------------------------


create procedure Addretsept
@retsepti_nimi varchar(100),
@kirjeldus varchar(200),
@juhend varchar(500),
@sisetatud_kp date,
@kasutaja_id int,
@kategoria_id int
as
begin

insert into retsept(retsepti_nimi,kirjeldus,juhend,sisetatud_kp,kasutaja_id,kategoria_id)
values(@retsepti_nimi,@kirjeldus,@juhend,@sisetatud_kp,@kasutaja_id,@kategoria_id);
end;

exec Addretsept @retsepti_nimi='Salat', @kirjeldus='tomat, kurk', @juhend='sega kõike', @sisetatud_kp='2025-03-03', @kasutaja_id=4, @kategoria_id=4
select * from retsept

create procedure addkoostis 
@kogus int,
@retsept_retsept_id int,
@toiduaine_id int,
@yhik_id int
as 
begin
insert into koostis(kogus,retsept_retsept_id,toiduaine_id,yhik_id)
values (@kogus,@retsept_retsept_id,@toiduaine_id,@yhik_id)
end;
exec addkoostis @kogus=5,@retsept_retsept_id=1 ,@toiduaine_id=1 ,@yhik_id=1

create procedure Addtehtud 
@tehtud_kp date,
@retsept_id int
as 
begin
insert into tehtud(tehtud_kp, retsept_id)
values(@tehtud_kp,@retsept_id)
end;

exec Addtehtud @tehtud_kp='2025-04-13', @retsept_id=4


create procedure veeruLisaKustutaTabelis
@tabel varchar (20),
@valik varchar(20),
@veerunimi varchar(20),
@tyyp varchar (20) =null
as

begin 
declare @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik='add' then CONCAT(' alter table ', @tabel, ' add ', @veerunimi, ' ', @tyyp)
when @valik='drop' then CONCAT( 'alter table ', @tabel, ' drop column ', @veerunimi)
end;
print @sqltegevus;
begin 
exec (@sqltegevus);
end
end;
exec veeruLisaKustutaTabelis  @valik= 'add', @tabel='yhik', @veerunimi='test', @tyyp='int';
exec veeruLisaKustutaTabelis  @valik='drop', @tabel='yhik', @veerunimi='test';

drop procedure veerulisakustutTabelis 

create table hind(
hind_id int primary key identity(1,1),
retsepti_hind int,
retsept_id int
foreign key (retsept_id) references retsept(retsept_id))

create procedure Addhind
@retsepti_hind int,
@retsept_id int
as
begin

insert into hind(retsepti_hind,retsept_id)
values (@retsepti_hind,@retsept_id)
end;

exec Addhind @retsepti_hind= 100, @retsept_id= 1
select * from hind


create procedure delete_hind
@deleteId int
as
begin
delete from hind where hind_id=@deleteId;
end;

exec delete_hind 5
