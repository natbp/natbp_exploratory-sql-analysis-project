-- PLEASE READ THIS BEFORE RUNNING THE EXERCISE

-- ⚠️ IMPORTANT: This SQL file may crash due to two common issues: comments and missing semicolons.

-- ✅ Suggestions:
-- 1) Always end each SQL query with a semicolon `;`
-- 2) Ensure comments are well-formed:
--    - Use `--` for single-line comments only
--    - Avoid inline comments after queries
--    - Do not use `/* */` multi-line comments, as they may break execution

-- -----------------------------------------------
-- queries.sql
-- Complete each mission by writing your SQL query
-- directly below the corresponding instruction
-- -----------------------------------------------

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- Your query here;
--¿Cuáles son las primeras 10 observaciones registradas?
--Utiliza LIMIT para mostrar solo una parte de la tabla.;

SELECT * FROM observations
limit 10;


-- MISSION 2
-- Your query here;

--¿Qué identificadores de región (region_id) aparecen en los datos?
--Usa SELECT DISTINCT para evitar repeticiones.;
SELECT DISTINCT region_id
FROM observations;


-- MISSION 3
-- Your query here;
--¿Cuántas especies distintas (species_id) se han observado?
--Combina COUNT con DISTINCT para no contar duplicados.;
SELECT COUNT(DISTINCT species_id) AS total_species
FROM observations;


-- MISSION 4
-- Your query here;
--¿Cuántas observaciones hay para la región con region_id = 2?
--Aplica una condición con WHERE.;
SELECT COUNT(*) AS total_observaciones
FROM observations
WHERE region_id = 2;


-- MISSION 5
-- Your query here;
--¿Cuántas observaciones se registraron el día 1998-08-08?
--Filtra por fecha exacta usando igualdad.;
SELECT COUNT(*) AS total_observaciones_fecha
FROM observations
WHERE observation_date = '1998-08-08';



-- MISSION 6
-- Your query here;
--¿Cuál es el region_id con más observaciones?
--Agrupa por región y cuenta cuántas veces aparece cada una.;
 
--NOTA: No me quedo claro si debia solo mostrar solo el que tenia más observaciones o si mostrar
--todas las regiones, asi que hice las dos;
SELECT region_id, COUNT(*) AS mas_observaciones
FROM observations
GROUP BY region_id
ORDER BY mas_observaciones DESC
LIMIT 1;

SELECT region_id, COUNT(*) AS mas_observaciones
FROM observations
GROUP BY region_id
ORDER BY mas_observaciones DESC;


-- MISSION 7
-- Your query here;
--¿Cuáles son los 5 species_id más frecuentes?
--Agrupa, ordena por cantidad descendente y limita el resultado.;
SELECT species_id, COUNT(*) AS cantidad
FROM observations
GROUP BY species_id
ORDER BY cantidad DESC
LIMIT 5;


-- MISSION 8
-- Your query here;
--¿Qué especies (species_id) tienen menos de 5 registros?
--Agrupa por especie y usa HAVING para aplicar una condición.;

SELECT species_id, COUNT(*) AS menos_registros
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5;


-- MISSION 9
-- Your query here;
--¿Qué observadores (observer) registraron más observaciones?
--Agrupa por el nombre del observador y cuenta los registros.;
SELECT observer, COUNT(*) AS mas_observaciones
FROM observations
GROUP BY observer
ORDER BY mas_observaciones DESC;



-- MISSION 10
-- Your query here;
--Muestra el nombre de la región (regions.name) para cada observación.
--Relaciona observations con regions usando region_id.;
SELECT 
  observations.*, 
  regions.name AS region_name
FROM observations
JOIN regions
  ON observations.region_id = regions.id;


-- MISSION 11
-- Your query here;
--Muestra el nombre científico de cada especie registrada (species.scientific_name).
--Relaciona observations con species usando species_id.;
SELECT 
  observations.*, 
  species.scientific_name
FROM observations
JOIN species
  ON observations.species_id = species.id;


-- MISSION 12
-- Your query here;
--¿Cuál es la especie más observada por cada región?
--Agrupa por región y especie, y ordena por cantidad.;
SELECT
  region_name,
  scientific_name,
  cantidad
FROM (
  SELECT
    regions.name AS region_name,
    species.scientific_name,
    COUNT(observations.id) AS cantidad,
    ROW_NUMBER() OVER (
      PARTITION BY regions.id
      ORDER BY COUNT(observations.id) DESC
    ) AS fila
  FROM observations
  JOIN regions
    ON observations.region_id = regions.id
  JOIN species
    ON observations.species_id = species.id
  GROUP BY regions.id, species.id
)
WHERE fila = 1;



-- MISSION 13
-- Your query here;
--Inserta una nueva observación ficticia en la tabla observations.
--Asegúrate de incluir todos los campos requeridos por el esquema.;
INSERT INTO observations (species_id, region_id, observer, observation_date, latitude, longitude, count) VALUES (325, 2, 'Natalia Exploradora', '2026-02-05', 4.7110, -74.0721, 3);

