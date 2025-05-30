-- PLAYER STATS, Discovery:

USE football;

SELECT COUNT(*) FROM football.teams;

SELECT * FROM seasons;
SELECT * FROM players
WHERE name = 'Dominik Szoboszlai';

UPDATE players
SET age = timestampdiff(YEAR, date_of_birt, CURDATE());


select distinct home_team_id from matches WHERE winner = 'AWAY_TEAM';
select count(home_team_id) home_team_id from matches WHERE winner = 'AWAY_TEAM';

SELECT * FROM scores;
SELECT * FROM matches;

-- avg goals per match -total
SELECT
  SUM(full_time_home + full_time_away) AS total_goals,
  ROUND(AVG(full_time_home + full_time_away), 2) AS average_goals_per_match
FROM scores;

-- Goals per league
SELECT
  l.name AS league_name,
  SUM(s.full_time_home + s.full_time_away) AS total_goals
FROM scores s
JOIN matches m ON s.match_id = m.match_id
JOIN leagues l ON m.league_id = l.league_id
GROUP BY l.name
ORDER BY total_goals DESC;

-- teams with most and least goals scored
SELECT
  t.name AS team_name,
  SUM(CASE WHEN t.team_id = m.home_team_id THEN s.full_time_home
           WHEN t.team_id = m.away_team_id THEN s.full_time_away
           ELSE 0 END) AS total_goals
FROM scores s
JOIN matches m ON s.match_id = m.match_id
JOIN teams t ON t.team_id = m.home_team_id OR t.team_id = m.away_team_id
GROUP BY t.name
ORDER BY total_goals DESC;

