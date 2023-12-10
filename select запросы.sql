--Внимание: результаты запросов не должны быть пустыми, учтите это при заполнении таблиц.
set search_path to "music_service"

--Название и продолжительность самого длительного трека.
SELECT name_track, duration
FROM track
WHERE duration = (SELECT max(duration) FROM track)

--Название треков, продолжительность которых не менее 3,5 минут.
SELECT name_track
FROM track
WHERE duration > 3.5

--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name_collection
FROM collection
--WHERE year >= 2018 AND year <= 2020
WHERE year BETWEEN 2018 AND 2020

--Исполнители, чьё имя состоит из одного слова.
SELECT name_executor FROM executor
WHERE name_executor NOT LIKE '% %'

--Название треков, которые содержат слово «мой» или «my»
SELECT name_track
FROM track
WHERE name_track LIKE '%мой%' or name_track LIKE '%my%'

--Количество исполнителей в каждом жанре
SELECT g.name_genre, COUNT(e.name_executor) AS num_executors
FROM music_service.genre g
JOIN music_service.genre_executor ge ON g.genre_id = ge.genre_id
JOIN music_service.executor e ON ge.executor_id = e.executor_id
GROUP BY g.name_genre;

--Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(T.name_track) AS num_track
FROM track t
JOIN album a ON a.album_id = t.album_id
WHERE year BETWEEN 2018 AND 2020

--Средняя продолжительность треков по каждому альбому.
SELECT avg(duration), name_album
FROM track t
JOIN album a ON a.album_id = t.album_id
GROUP BY name_album

--Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT e.name_executor
FROM executor e
JOIN executor_album ea ON ea.executor_id = e.executor_id
JOIN album a ON a.album_id = ea.album_id
WHERE year not BETWEEN 2018 AND 2020

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT (name_collection) DI
FROM collection c
JOIN track_collection tc ON tc.collection_id = c.collection_id
JOIN track t ON t.track_id = tc.track_id
JOIN album a ON a.album_id = t.album_id
JOIN executor_album ea ON a.album_id = t.album_id
JOIN executor e ON e.executor_id = ea.executor_id
WHERE name_executor = 'Kurt Cobain'

--Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT a.name_album, COUNT(DISTINCT ge.genre_id) as num_genres
FROM executor_album ea
FULL OUTER JOIN genre_executor ge ON ea.executor_id = ge.executor_id
FULL OUTER JOIN album a ON ea.album_id = a.album_id
GROUP BY a.name_album
HAVING COUNT(DISTINCT ge.genre_id) > 1

--Наименования треков, которые не входят в сборники.
SELECT t.name_track
   FROM track t
   LEFT OUTER JOIN track_collection tc ON t.track_id = tc.track_id
   WHERE tc.track_id IS NULL

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
--РЕШЕНИЕ НЕ КОРЕКТНО ТАК КАК НЕРЕЛЕВАНТНА САМА СХЕМА. НУЖНА ПРЯМАЯ СВЯЗЬ МЕЖДУ ТРЕКОМ И ИСПОЛНИТЕЛЕМ, 
--ДЛЯ ЭТОГО В ТАБЛИЦЕ track НЕОБХОДИМО ДОБАВЛЕНИЕ ГРАФЫ executor_ID. В ПРОТИВНОМ СЛУЧАЕ ИСПОЛНИТЕЛИ 
--У КОТОРЫХ НЕТ АЛЬБОМА ПРОСТО НЕ ПОПАДУТ В ВЫБОРКУ.
SELECT e.name_executor, t.duration
FROM (
    SELECT t.track_id, t.name_track, t.duration, ea.executor_id 
    FROM track t 
    JOIN executor_album ea ON t.album_id = ea.album_id 
    WHERE t.duration = (SELECT MIN(duration) FROM track)
) t 
JOIN executor e ON t.executor_id = e.executor_id

--Названия альбомов, содержащих наименьшее количество треков.
SELECT name_album, (count(t.track_id)) AS count_track
FROM album a
JOIN track t ON t.album_id = a.album_id  
GROUP BY name_album
ORDER BY count_track
LIMIT 1
