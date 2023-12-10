
CREATE SCHEMA music_service

set search_path to "music_service"

CREATE TABLE IF NOT EXISTS genre (  -- жанр 3
	genre_id SERIAL NOT NULL,
	name_genre varchar(100) NOT NULL,
	CONSTRAINT genre_id_pkey PRIMARY KEY (genre_id)
	)

INSERT INTO genre (name_genre) -- наполняю жанр
values ('classical'),
		('blues'),
		('jazz'),
		('rock'),
		('rap'),
		('pop')

CREATE TABLE IF NOT EXISTS executor (  -- исполнитель
	executor_id SERIAL NOT NULL,
	name_executor varchar(100) NOT NULL,
	CONSTRAINT executor_id_pkey PRIMARY KEY (executor_id)
	)

INSERT INTO executor (name_executor)  -- наполняю исполнитель
values ('Ludwig van Beethoven'),     -- classical
		('Wolfgang Amadeus Mozart'),  -- classical
		('Frank Sinatra'),   -- jazz
		('Kurt Cobain'),    -- rock
		('B.B. King'),    -- blues
		('Дэцл'),     --rap
		('Бузова')    --pop

CREATE TABLE IF NOT EXISTS album (   -- альбом
	album_id SERIAL NOT NULL,
	name_album varchar(100) NOT NULL,
	year integer NOT NULL,
	CONSTRAINT album_id_pkey PRIMARY KEY (album_id),
	CONSTRAINT year_check CHECK (year >= 1000 AND year <= 9999)
	)

INSERT INTO album (name_album, year)  -- наполняю альбом
values ('String Quartets', 1803),     -- Ludwig van Beethoven
		('Diabelli Variations', 1805),     -- Ludwig van Beethoven
		('Mozart s Greates Hits', 1783),  -- Wolfgang Amadeus Mozart
		('The Voice Of Frank Sinatra', 1945),   -- Frank Sinatra
		('The Home Recordings', 1985),   -- Kurt Cobain
		('The blues', 2005),    -- B.B. King
		('My worst dream', 2019)  -- Дэцл, Бузова

CREATE TABLE IF NOT EXISTS track (   --трек
	track_id SERIAL NOT NULL,
	name_track varchar(100) NOT NULL,
	duration float NOT NULL,
	album_id integer NOT NULL,
	CONSTRAINT track_id_pkey PRIMARY KEY (track_id),
	CONSTRAINT album_id_fkey FOREIGN KEY (album_id) REFERENCES music_service.album(album_id)
	)

INSERT INTO track (name_track, duration, album_id)   -- наполняю трек
VALUES ('Try A Little Tenderness', 2.37, 5),   -- Kurt Cobain
		('These Foolish Things', 3.45, 5),   -- Kurt Cobain
		('You Go To My Head', 3.56, 5),   -- Kurt Cobain
		('Why Do Things Happen To Me', 2.38, 6),    -- B.B. King
		('Ruby Lee', 1.59, 6),    -- B.B. King
		('When my Heart Beats Like A Hammer', 12.59, 6),    -- B.B. King
		('half is not enough for me', 4.56, 7),  -- Дэцл, Бузова
		('мой худший трек', 2.53, 7)  -- Дэцл, Бузова

CREATE TABLE IF NOT EXISTS collection (   -- сборник
	collection_id SERIAL NOT NULL,
	name_collection varchar(100) NOT NULL,
	year integer NOT NULL,
	CONSTRAINT collection_id_pkey PRIMARY KEY (collection_id),
	CONSTRAINT year_check CHECK (year >= 1000 AND year <= 9999)
	)

INSERT INTO collection (name_collection, year)  -- наполняю сборник
VALUES ('collection2019', 2019),   -- Kurt Cobain
		('New Year s collection', 1968),   -- Kurt Cobain
		('New collection', 1986),   -- Kurt Cobain
		('COOL collection', 1976)    -- B.B. King

CREATE TABLE IF NOT EXISTS genre_executor (       -- жанр-исполнитель
	genre_executor_id SERIAL NOT NULL,
	genre_id integer NOT NULL,
	executor_id integer NOT NULL,
	CONSTRAINT genre_id_fkey FOREIGN KEY (genre_id) REFERENCES music_service.genre(genre_id),
	CONSTRAINT executor_id_fkey FOREIGN KEY (executor_id) REFERENCES music_service.executor(executor_id)
	)

INSERT INTO genre_executor (genre_id, executor_id)   -- наполняю жанр-исполнитель
VALUES  (1, 1),
		(1, 2),
		(2, 5),
		(3, 3),
		(4, 4),
		(5, 6),
		(6, 7)

CREATE TABLE IF NOT EXISTS executor_album (   -- исполнитель-альбом
	executor_album_id SERIAL NOT NULL,
	executor_id integer NOT NULL,
	album_id integer NOT NULL,
	CONSTRAINT executor_id_fkey FOREIGN KEY (executor_id) REFERENCES music_service.executor(executor_id),
	CONSTRAINT album_id_fkey FOREIGN KEY (album_id) REFERENCES music_service.album(album_id)
	)

INSERT INTO executor_album (executor_id, album_id)  -- наполняю исполнитель-альбом
VALUES  (1, 1),
		(1, 2),
		(2, 3),
		(3, 4),
		(4, 5),
		(5, 6),
		(6, 7),
		(7, 7)	
		
CREATE TABLE IF NOT EXISTS track_collection (   -- трек-коллекция
	track_collection_id SERIAL NOT NULL,
	track_id integer NOT NULL,
	collection_id integer NOT NULL,
	CONSTRAINT track_id_fkey FOREIGN KEY (track_id) REFERENCES music_service.track(track_id),
	CONSTRAINT collection_id_fkey FOREIGN KEY (collection_id) REFERENCES music_service.collection(collection_id)
	)

INSERT INTO track_collection (track_id, collection_id)   --наполняю трек-коллекция
VALUES  (1, 1),
		(2, 1),
		(3, 2),
		(4, 2),
		(2, 2),
		(1, 3),
		(2, 3),
		(3, 3),
		(4, 4),
		(5, 4),
		(6, 4)
		
--DROP schema music_service CASCADE
