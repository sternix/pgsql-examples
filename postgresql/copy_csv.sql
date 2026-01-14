-- örnek bir csv dosyası
wget https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artists.csv

CREATE TABLE artists
(
    ConstituentID int,
    DisplayName varchar(255),
    ArtistBio varchar(255),
    Nationality varchar(255),
    Gender varchar(25),
    BeginDate int,
    EndDate int,
    WikiQID varchar(25),
    ULAN int
);

\COPY ARTISTS FROM 'Artists.csv' WITH DELIMITER ',' CSV HEADER