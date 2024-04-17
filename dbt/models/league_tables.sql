{{ config(materialized='view') }}


WITH home as (
  SELECT league_name, league_country, league_season, teams_home_name as team_name,
    SUM(CASE WHEN winner = 1 THEN 3
              WHEN winner = 0  THEN 1
              ELSE 0 END
    ) AS points_home,
    COUNT(*) as games_home,
    SUM(score_fulltime_home) as goals_scored_home,
    SUM(score_fulltime_away) as goals_conceded_home
  FROM `project.dataset.table`
  GROUP BY league_name, league_country, league_season, teams_home_name
),
away as (
  SELECT league_name, league_country, league_season, teams_away_name as team_name,
    SUM(CASE WHEN winner = 2 THEN 3
              WHEN winner = 0  THEN 1
              ELSE 0 END
    ) AS points_away,
    COUNT(*) as games_away,
    SUM(score_fulltime_away) as goals_scored_away,
    SUM(score_fulltime_home) as goals_conceded_away
  FROM `project.dataset.table`
  GROUP BY league_name, league_country, league_season, teams_away_name
)



SELECT
  ROW_NUMBER() OVER (PARTITION BY home.league_name, home.league_season ORDER BY home.points_home + away.points_away DESC) AS pos,
  home.league_name,
  /*home.league_country,*/
  home.league_season,
  home.team_name,
  home.games_home,
  home.goals_scored_home,
  home.goals_conceded_home,
  home.points_home,
  away.games_away,
  away.goals_scored_away,
  away.goals_conceded_away,
  away.points_away,
  home.games_home + away.games_away as total_games,
  home.goals_scored_home + away.goals_scored_away as total_goals_scored,
  home.goals_conceded_home + away.goals_conceded_away as total_goals_conceded,
  home.points_home + away.points_away as total_points
FROM home
LEFT JOIN away
ON home.team_name = away.team_name
AND home.league_season = away.league_season
ORDER BY league_season, league_name, total_points DESC