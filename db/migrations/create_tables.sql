CREATE TABLE players(
  player_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  nationality VARCHAR(20) NOT NULL,
  birth_date DATE NOT NULL,
  score INTEGER DEFAULT 1200
  );
