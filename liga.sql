/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     24.11.2019 19:22:27                          */
/*==============================================================*/


/*==============================================================*/
/* Table: Akcja_meczu                                           */
/*==============================================================*/
create table Akcja_meczu 
(
   ID_AKCJI             integer                        not null,
   ID_MECZU             integer                        not null,
   ID_PRACOWNIKA        integer                        not null,
   RODZAJ               long varchar                   not null,
   MINUTA               integer                        not null,
   constraint PK_AKCJA_MECZU primary key (ID_AKCJI)
);

comment on table Akcja_meczu is 
'Akcja podczas meczu - gol, asysta, kartka';

comment on column Akcja_meczu.ID_AKCJI is 
'Identyfikator akcji';

comment on column Akcja_meczu.ID_MECZU is 
'Identyfikator meczu';

comment on column Akcja_meczu.ID_PRACOWNIKA is 
'Identyfikator pracownika';

comment on column Akcja_meczu.RODZAJ is 
'Rodzaj akcji - kartka, gol, asysta itp.';

comment on column Akcja_meczu.MINUTA is 
'Minuta akcji';

/*==============================================================*/
/* Index: Akcja_meczu_PK                                        */
/*==============================================================*/
create unique index Akcja_meczu_PK on Akcja_meczu (
ID_AKCJI ASC
);

/*==============================================================*/
/* Index: FK_AKCJA_MECZ_FK                                      */
/*==============================================================*/
create index FK_AKCJA_MECZ_FK on Akcja_meczu (
ID_MECZU ASC
);

/*==============================================================*/
/* Index: FK_AKCJA_ZAWODNIK_FK                                  */
/*==============================================================*/
create index FK_AKCJA_ZAWODNIK_FK on Akcja_meczu (
ID_PRACOWNIKA ASC
);

/*==============================================================*/
/* Table: Firma                                                 */
/*==============================================================*/
create table Firma 
(
   ID_FIRMY             integer                        not null,
   NIP                  varchar(13)                    not null,
   TELEFON              varchar(12)                    not null,
   ADRES                varchar(80)                    not null,
   constraint PK_FIRMA primary key (ID_FIRMY),
   constraint AK_ID_NIP_FIRMA unique (NIP)
);

comment on table Firma is 
'Firma zawieraj¹ca kontkrakt z klubem';

comment on column Firma.ID_FIRMY is 
'Identyfikator firmy';

comment on column Firma.NIP is 
'Numer NIP firmy';

comment on column Firma.TELEFON is 
'Telefon do firmy';

comment on column Firma.ADRES is 
'Adres siedziby firmy (zameldowania)';

comment on index Firma.AK_ID_NIP_FIRMA is 
'Identyfikator NIP';

/*==============================================================*/
/* Index: Firma_PK                                              */
/*==============================================================*/
create unique index Firma_PK on Firma (
ID_FIRMY ASC
);

/*==============================================================*/
/* Index: Firma_AK                                              */
/*==============================================================*/
create unique index Firma_AK on Firma (
NIP ASC
);

/*==============================================================*/
/* Table: Klub                                                  */
/*==============================================================*/
create table Klub 
(
   ID_KLUBU             varchar(30)                    not null,
   NAZWA                varchar(80)                    not null,
   NIP                  varchar(13)                    not null,
   ADRES                varchar(60)                    not null,
   constraint PK_KLUB primary key (ID_KLUBU),
   constraint AK_ID_NIP_KLUB unique (NIP)
);

comment on table Klub is 
'Klub graj¹cy w lidze';

comment on column Klub.ID_KLUBU is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Klub.NAZWA is 
'Nazwa klubu';

comment on column Klub.NIP is 
'Numer NIP klubu';

comment on column Klub.ADRES is 
'Adres siedziby klubu - adres zameldowania';

/*==============================================================*/
/* Index: Klub_PK                                               */
/*==============================================================*/
create unique index Klub_PK on Klub (
ID_KLUBU ASC
);

/*==============================================================*/
/* Index: Klub_AK                                               */
/*==============================================================*/
create unique index Klub_AK on Klub (
NIP ASC
);

/*==============================================================*/
/* Table: Kontrakt                                              */
/*==============================================================*/
create table Kontrakt 
(
   ID_KONTRAKTU         integer                        not null,
   ID_KUPUJACEGO        varchar(30)                    null,
   ID_SPRZEDAJACEGO     varchar(30)                    null,
   ID_FIRMY             integer                        null,
   ID_TYPU              integer                        not null,
   ID_PERSONELU         integer                        null,
   ID_ZAWODNIKA         integer                        null,
   DATA_ZAW             date                           not null,
   DATA_WAZ             date                           not null,
   KWOTA                decimal(15,2)                  not null,
   constraint PK_KONTRAKT primary key (ID_KONTRAKTU)
);

comment on table Kontrakt is 
'Kontrakt zawierany w lidze';

comment on column Kontrakt.ID_KONTRAKTU is 
'Identyfikator kontraktu';

comment on column Kontrakt.ID_KUPUJACEGO is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Kontrakt.ID_SPRZEDAJACEGO is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Kontrakt.ID_FIRMY is 
'Identyfikator firmy';

comment on column Kontrakt.ID_TYPU is 
'Identyfiktor typu kontraktu';

comment on column Kontrakt.ID_PERSONELU is 
'Identyfikator pracownika';

comment on column Kontrakt.ID_ZAWODNIKA is 
'Identyfikator pracownika';

comment on column Kontrakt.DATA_ZAW is 
'Data zawarcia kontraktu';

comment on column Kontrakt.DATA_WAZ is 
'Data wa¿noœci kontraktu';

comment on column Kontrakt.KWOTA is 
'Kwota na jak¹ opiewa kontrakt';

/*==============================================================*/
/* Index: Kontrakt_PK                                           */
/*==============================================================*/
create unique index Kontrakt_PK on Kontrakt (
ID_KONTRAKTU ASC
);

/*==============================================================*/
/* Index: FK_TYP_KONTRAKTU_KONTRAKT_FK                          */
/*==============================================================*/
create index FK_TYP_KONTRAKTU_KONTRAKT_FK on Kontrakt (
ID_TYPU ASC
);

/*==============================================================*/
/* Index: FK_SPRZEDAJACY_KONTRAKT_FK                            */
/*==============================================================*/
create index FK_SPRZEDAJACY_KONTRAKT_FK on Kontrakt (
ID_KUPUJACEGO ASC
);

/*==============================================================*/
/* Table: Mecz                                                  */
/*==============================================================*/
create table Mecz 
(
   ID_MECZU             integer                        not null,
   ID_OBIEKTU           integer                        not null,
   ID_GOSPODARZA        varchar(30)                    not null,
   ID_GOSCIA            varchar(30)                    not null,
   ID_SEDZIEGO          integer                        not null,
   WYNIK                integer                        not null,
   GOLE_GOSCIA          integer                        not null,
   constraint PK_MECZ primary key (ID_MECZU)
);

comment on table Mecz is 
'Mecz ligowy pomiêdzy dru¿ynami';

comment on column Mecz.ID_MECZU is 
'Identyfikator meczu';

comment on column Mecz.ID_OBIEKTU is 
'Identyfikator miejsca pracy (budynku)';

comment on column Mecz.ID_GOSPODARZA is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Mecz.ID_GOSCIA is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Mecz.ID_SEDZIEGO is 
'Identyfikator pracownika';

comment on column Mecz.WYNIK is 
'Iloœæ bramek strzelonych przez gospodarza';

comment on column Mecz.GOLE_GOSCIA is 
'Iloœæ bramek strzelonych przez goœcia';

/*==============================================================*/
/* Index: Mecz_PK                                               */
/*==============================================================*/
create unique index Mecz_PK on Mecz (
ID_MECZU ASC
);

/*==============================================================*/
/* Index: FK_KLUB_MECZ_GOSPODARZ_FK                             */
/*==============================================================*/
create index FK_KLUB_MECZ_GOSPODARZ_FK on Mecz (
ID_GOSPODARZA ASC
);

/*==============================================================*/
/* Index: FK_KLUB_MECZ_GOSC_FK                                  */
/*==============================================================*/
create index FK_KLUB_MECZ_GOSC_FK on Mecz (
ID_GOSCIA ASC
);

/*==============================================================*/
/* Index: FK_OBIEKT_MECZ_FK                                     */
/*==============================================================*/
create index FK_OBIEKT_MECZ_FK on Mecz (
ID_OBIEKTU ASC
);

/*==============================================================*/
/* Index: FK_PERSONEL_MECZ_FK                                   */
/*==============================================================*/
create index FK_PERSONEL_MECZ_FK on Mecz (
ID_SEDZIEGO ASC
);

/*==============================================================*/
/* Table: Obiekt                                                */
/*==============================================================*/
create table Obiekt 
(
   ID_OBIEKTU           integer                        not null,
   ID_KLUBU             varchar(30)                    not null,
   NAZWA                long varchar                   null,
   ADRES                varchar(60)                    not null,
   constraint PK_OBIEKT primary key (ID_OBIEKTU)
);

comment on table Obiekt is 
'Obiekt nale¿¹cy do klubu';

comment on column Obiekt.ID_OBIEKTU is 
'Identyfikator miejsca pracy (budynku)';

comment on column Obiekt.ID_KLUBU is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Obiekt.NAZWA is 
'Nazwa obiektu';

comment on column Obiekt.ADRES is 
'Adres obiektu';

/*==============================================================*/
/* Index: Obiekt_PK                                             */
/*==============================================================*/
create unique index Obiekt_PK on Obiekt (
ID_OBIEKTU ASC
);

/*==============================================================*/
/* Index: FK_KLUB_OBIEKT_FK                                     */
/*==============================================================*/
create index FK_KLUB_OBIEKT_FK on Obiekt (
ID_KLUBU ASC
);

/*==============================================================*/
/* Table: Personel                                              */
/*==============================================================*/
create table Personel 
(
   ID_PRACOWNIKA        integer                        not null,
   ID_OBIEKTU           integer                        null,
   ID_KLUBU             varchar(30)                    null,
   ID_STANOWISKA        integer                        not null,
   NAZWISKO             varchar(30)                    not null,
   IMIE                 varchar(30)                    not null,
   PESEL                varchar(11)                    not null,
   DATA_URODZENIA       date                           not null,
   KRAJ                 varchar(30)                    not null,
   ETAT                 smallint                       not null,
   PRZELOZONY           varchar(80)                    not null,
   constraint PK_PERSONEL primary key    (ID_PRACOWNIKA)
);

comment on table Personel is 
'Personel pracuj¹cy w klubie';

comment on column Personel.ID_PRACOWNIKA is 
'Identyfikator pracownika';

comment on column Personel.ID_OBIEKTU is 
'Identyfikator miejsca pracy (budynku)';

comment on column Personel.ID_KLUBU is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Personel.ID_STANOWISKA is 
'Identyfikator rodzaju stanowiska';

comment on column Personel.NAZWISKO is 
'Nazwisko pracownika';

comment on column Personel.IMIE is 
'Imiê pracownika';

comment on column Personel.PESEL is 
'Numer PESEL pracownika';

comment on column Personel.DATA_URODZENIA is 
'Data urodzenia pracownika';

comment on column Personel.KRAJ is 
'Narodowoœæ pracownika';

comment on column Personel.ETAT is 
'Etat pracownika (liczba godzin pracy w tygodniu)';

comment on column Personel.PRZELOZONY is 
'Prze³o¿ony pracownika';

/*==============================================================*/
/* Index: Personel_PK                                           */
/*==============================================================*/
create unique    index Personel_PK on Personel (
ID_PRACOWNIKA ASC
);

/*==============================================================*/
/* Index: FK_OBIEKT_PERSONEL_FK                                 */
/*==============================================================*/
create index FK_OBIEKT_PERSONEL_FK on Personel (
ID_OBIEKTU ASC
);

/*==============================================================*/
/* Index: FK_KLUB_PERSONEL_FK                                   */
/*==============================================================*/
create index FK_KLUB_PERSONEL_FK on Personel (
ID_KLUBU ASC
);

/*==============================================================*/
/* Index: FK_STANOWISKO_PERSONEL_FK                             */
/*==============================================================*/
create index FK_STANOWISKO_PERSONEL_FK on Personel (
ID_STANOWISKA ASC
);

/*==============================================================*/
/* Table: Stanowisko                                            */
/*==============================================================*/
create table Stanowisko 
(
   ID_STANOWISKA        integer                        not null,
   RODZAJ               varchar(30)                    not null,
   constraint PK_STANOWISKO primary key (ID_STANOWISKA)
);

comment on table Stanowisko is 
'Stanowisko pracownika klubu';

comment on column Stanowisko.ID_STANOWISKA is 
'Identyfikator rodzaju stanowiska';

comment on column Stanowisko.RODZAJ is 
'Rodzaj stanowiska dla pracownika';

/*==============================================================*/
/* Index: Stanowisko_PK                                         */
/*==============================================================*/
create unique index Stanowisko_PK on Stanowisko (
ID_STANOWISKA ASC
);

/*==============================================================*/
/* Table: Typ_kontraktu                                         */
/*==============================================================*/
create table Typ_kontraktu 
(
   ID_TYPU              integer                        not null,
   RODZAJ               varchar(25)                    not null,
   constraint PK_TYP_KONTRAKTU primary key (ID_TYPU)
);

comment on table Typ_kontraktu is 
'Typ kontraktu zawieranego przez strony';

comment on column Typ_kontraktu.ID_TYPU is 
'Identyfiktor typu kontraktu';

comment on column Typ_kontraktu.RODZAJ is 
'Rodzaj zawieranego kontraktu';

/*==============================================================*/
/* Index: Typ_kontraktu_PK                                      */
/*==============================================================*/
create unique index Typ_kontraktu_PK on Typ_kontraktu (
ID_TYPU ASC
);

/*==============================================================*/
/* Table: Zawodnik                                              */
/*==============================================================*/
create table Zawodnik 
(
   ID_PRACOWNIKA        integer                        not null,
   ID_KLUBU             varchar(30)                    null,
   NAZWISKO             varchar(30)                    not null,
   IMIE                 varchar(30)                    not null,
   PESEL                varchar(11)                    not null,
   DATA_URODZENIA       date                           not null,
   KRAJ                 varchar(30)                    not null,
   POZYCJA              varchar(20)                    not null,
   OVERALL              smallint                       not null,
   NUMER                smallint                       not null,
   constraint PK_ZAWODNIK primary key    (ID_PRACOWNIKA)
);

comment on table Zawodnik is 
'Zawodnik klubu';

comment on column Zawodnik.ID_PRACOWNIKA is 
'Identyfikator pracownika';

comment on column Zawodnik.ID_KLUBU is 
'Identyfikator klubu graj¹cego w lidze';

comment on column Zawodnik.NAZWISKO is 
'Nazwisko pracownika';

comment on column Zawodnik.IMIE is 
'Imiê pracownika';

comment on column Zawodnik.PESEL is 
'Numer PESEL pracownika';

comment on column Zawodnik.DATA_URODZENIA is 
'Data urodzenia pracownika';

comment on column Zawodnik.KRAJ is 
'Narodowoœæ pracownika';

comment on column Zawodnik.POZYCJA is 
'Pozycja na jakiej wystêpuje w klubie';

comment on column Zawodnik.OVERALL is 
'Œrednia ocena umiejêtnoœci zawodnika';

comment on column Zawodnik.NUMER is 
'Numer na koszulce z jakim gra zawodnik';

/*==============================================================*/
/* Index: Zawodnik_PK                                           */
/*==============================================================*/
create unique    index Zawodnik_PK on Zawodnik (
ID_PRACOWNIKA ASC
);

/*==============================================================*/
/* Index: FK_KLUB_ZAWODNIK_FK                                   */
/*==============================================================*/
create index FK_KLUB_ZAWODNIK_FK on Zawodnik (
ID_KLUBU ASC
);

alter table Akcja_meczu
   add constraint FK_AKCJA_ME_FK_AKCJA__MECZ foreign key (ID_MECZU)
      references Mecz (ID_MECZU)
      on update restrict
      on delete restrict;

alter table Akcja_meczu
   add constraint FK_AKCJA_ME_FK_AKCJA__ZAWODNIK foreign key (ID_PRACOWNIKA)
      references Zawodnik (ID_PRACOWNIKA)
      on update restrict
      on delete restrict;

alter table Kontrakt
   add constraint FK_KONTRAKT_FK_FIRMA__FIRMA foreign key (ID_FIRMY)
      references Firma (ID_FIRMY)
      on update restrict
      on delete restrict;

alter table Kontrakt
   add constraint FK_KONTRAKT_FK_KUPUJA_KLUB foreign key (ID_SPRZEDAJACEGO)
      references Klub (ID_KLUBU)
      on update restrict
      on delete restrict;

alter table Kontrakt
   add constraint FK_KONTRAKT_FK_SPRZED_KLUB foreign key (ID_KUPUJACEGO)
      references Klub (ID_KLUBU)
      on update restrict
      on delete restrict;

comment on foreign key Kontrakt.FK_KONTRAKT_FK_SPRZED_KLUB is 
'Relacja klubu sprzedaj¹cego i kontraktu';

alter table Kontrakt
   add constraint FK_KONTRAKT_FK_TYP_KO_TYP_KONT foreign key (ID_TYPU)
      references Typ_kontraktu (ID_TYPU)
      on update restrict
      on delete restrict;

comment on foreign key Kontrakt.FK_KONTRAKT_FK_TYP_KO_TYP_KONT is 
'Ka¿dy kontrakt ma swój typ';

alter table Kontrakt
   add constraint FK_KONTRAKT_FK_TYP_KO_PERSONEL foreign key (ID_PERSONELU)
      references Personel (ID_PRACOWNIKA)
      on update restrict
      on delete restrict;

comment on foreign key Kontrakt.FK_KONTRAKT_FK_TYP_KO_PERSONEL is 
'Personel zawiera kontrakt o okreœlonym typie';

alter table Kontrakt
   add constraint FK_KONTRAKT_FK_TYP_KO_ZAWODNIK foreign key (ID_ZAWODNIKA)
      references Zawodnik (ID_PRACOWNIKA)
      on update restrict
      on delete restrict;

alter table Mecz
   add constraint FK_MECZ_GOSC foreign key (ID_GOSCIA)
      references Klub (ID_KLUBU)
      on update restrict
      on delete restrict;

alter table Mecz
   add constraint FK_MECZ_GOSPODARZ foreign key (ID_GOSPODARZA)
      references Klub (ID_KLUBU)
      on update restrict
      on delete restrict;

alter table Mecz
   add constraint FK_MECZ_FK_OBIEKT_OBIEKT foreign key (ID_OBIEKTU)
      references Obiekt (ID_OBIEKTU)
      on update restrict
      on delete restrict;

alter table Mecz
   add constraint FK_MECZ_FK_PERSON_PERSONEL foreign key (ID_SEDZIEGO)
      references Personel (ID_PRACOWNIKA)
      on update restrict
      on delete restrict;

alter table Obiekt
   add constraint FK_OBIEKT_FK_KLUB_O_KLUB foreign key (ID_KLUBU)
      references Klub (ID_KLUBU)
      on update restrict
      on delete restrict;

alter table Personel
   add constraint FK_PERSONEL_FK_KLUB_P_KLUB foreign key (ID_KLUBU)
      references Klub (ID_KLUBU)
      on update restrict
      on delete restrict;

comment on foreign key Personel.FK_PERSONEL_FK_KLUB_P_KLUB is 
'Ka¿dy klub ma personel (przynajmniej w³aœciciela)';

alter table Personel
   add constraint FK_PERSONEL_FK_OBIEKT_OBIEKT foreign key (ID_OBIEKTU)
      references Obiekt (ID_OBIEKTU)
      on update restrict
      on delete restrict;

alter table Personel
   add constraint FK_PERSONEL_FK_STANOW_STANOWIS foreign key (ID_STANOWISKA)
      references Stanowisko (ID_STANOWISKA)
      on update restrict
      on delete restrict;

alter table Zawodnik
   add constraint FK_ZAWODNIK_FK_KLUB_Z_KLUB foreign key (ID_KLUBU)
      references Klub (ID_KLUBU)
      on update restrict
      on delete restrict;

