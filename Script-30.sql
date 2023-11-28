
CREATE SCHEMA music_service

set search_path to "music_service"

CREATE TABLE IF NOT EXISTS genre (
	genre_id SERIAL NOT NULL,
	name_genre varchar(100) NOT NULL,
	CONSTRAINT genre_id_pkey PRIMARY KEY (genre_id)
	)

CREATE TABLE IF NOT EXISTS executor (
	executor_id SERIAL NOT NULL,
	name_executor varchar(100) NOT NULL,
	CONSTRAINT executor_id_pkey PRIMARY KEY (executor_id)
	)

CREATE TABLE IF NOT EXISTS album (
	album_id SERIAL NOT NULL,
	name_album varchar(100) NOT NULL,
	CONSTRAINT album_id_pkey PRIMARY KEY (album_id)
	)
	
CREATE TABLE IF NOT EXISTS track (
	track_id SERIAL NOT NULL,
	name_track varchar(100) NOT NULL,
	duration numeric(2, 2) NOT NULL,
	album_id integer NOT NULL,
	CONSTRAINT track_id_pkey PRIMARY KEY (track_id),
	CONSTRAINT album_id_fkey FOREIGN KEY (album_id) REFERENCES music_service.album(album_id)
	)
	
CREATE TABLE IF NOT EXISTS collection (
	collection_id SERIAL NOT NULL,
	name_collection varchar(100) NOT NULL,
	year integer NOT NULL,
	CONSTRAINT collection_id_pkey PRIMARY KEY (collection_id),
	CONSTRAINT year_check CHECK (year >= 1000 AND year <= 9999)
	)

CREATE TABLE IF NOT EXISTS genre_executor (
	genre_executor_id SERIAL NOT NULL,
	genre_id integer NOT NULL,
	executor_id integer NOT NULL,
	CONSTRAINT genre_id_fkey FOREIGN KEY (genre_id) REFERENCES music_service.genre(genre_id),
	CONSTRAINT executor_id_fkey FOREIGN KEY (executor_id) REFERENCES music_service.executor(executor_id)
	)
	
CREATE TABLE IF NOT EXISTS executor_album (
	executor_album_id SERIAL NOT NULL,
	executor_id integer NOT NULL,
	album_id integer NOT NULL,
	CONSTRAINT executor_id_fkey FOREIGN KEY (executor_id) REFERENCES music_service.executor(executor_id),
	CONSTRAINT album_id_fkey FOREIGN KEY (album_id) REFERENCES music_service.album(album_id)
	)
	
CREATE TABLE IF NOT EXISTS track_collection (
	track_collection_id SERIAL NOT NULL,
	track_id integer NOT NULL,
	collection_id integer NOT NULL,
	CONSTRAINT track_id_fkey FOREIGN KEY (track_id) REFERENCES music_service.track(track_id),
	CONSTRAINT collection_id_fkey FOREIGN KEY (collection_id) REFERENCES music_service.collection(collection_id)
	)
	


