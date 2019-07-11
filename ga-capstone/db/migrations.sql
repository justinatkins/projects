DROP DATABASE IF EXISTS guitars;
CREATE DATABASE guitars;

\c guitars 

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR(32),
	password_digest VARCHAR(60)
);

CREATE TABLE bands(
	id SERIAL PRIMARY KEY, 
	band_url VARCHAR(4000),
	band_name VARCHAR(256),
	user_id INTEGER REFERENCES users(id)
);


CREATE TABLE guitarists(
	id SERIAL PRIMARY KEY,
	guitarist_url VARCHAR(2000),
	name VARCHAR(128),
	user_id INTEGER REFERENCES users(id),
	band_id INTEGER REFERENCES bands(id) -- guitarist belongs to band
	-- guitar_id INTEGER REFERENCES guitars(id)
);

CREATE TABLE guitars(
	id SERIAL PRIMARY KEY,
	guitar_url VARCHAR(2000),
	year SMALLINT,
	make VARCHAR(60),
	model VARCHAR(60),
	finish VARCHAR(60),
	user_id INTEGER REFERENCES users(id) 
);

CREATE TABLE instrument_choices(
	id SERIAL PRIMARY KEY,
	-- instr choice BELONGS TO guitarist
	guitarist_id INTEGER REFERENCES guitarists(id), -- use thru table to get guitarists, then a loop to get band for each guitarist
	guitar_id INTEGER REFERENCES guitars(id) # instrument choice BELONGS TO guitar
);

-- CREATE TABLE musicians_bands(
-- 	id SERIAL PRIMARY KEY,
-- 	band_id INTEGER REFERENCES bands(id),
-- 	guitarist_id INTEGER REFERENCES guitarists(id)
-- );

-- CREATE TABLE instrument_choices_bands(
-- 	id SERIAL PRIMARY KEY,
-- 	band_id INTEGER REFERENCES bands(id),
-- 	guitar_id INTEGER REFERENCES guitars(id) 
-- );





