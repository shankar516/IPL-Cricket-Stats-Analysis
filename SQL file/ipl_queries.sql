-- =====================================================
-- IPL CRICKET STATISTICS ANALYSIS
-- SQL Queries
-- =====================================================

-- Use your database first
-- Example:
-- USE ipl_analysis;


-- 1. View first 10 rows from matches table
SELECT *
FROM matches_clean
LIMIT 10;


-- 2. Total number of IPL matches
SELECT COUNT(*) AS total_matches
FROM matches_clean;


-- 3. Total IPL seasons
SELECT COUNT(DISTINCT season_year) AS total_seasons
FROM matches_clean;


-- 4. Total teams
SELECT COUNT(DISTINCT winner) AS total_teams
FROM matches_clean
WHERE winner IS NOT NULL;


-- 5. Top 10 IPL teams by total wins
SELECT
    winner AS team,
    COUNT(*) AS total_wins
FROM matches_clean
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC
LIMIT 10;


-- 6. Top 10 IPL run scorers
SELECT
    batter,
    SUM(batsman_runs) AS total_runs
FROM deliveries_clean
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;


-- 7. Top 10 IPL wicket takers
SELECT
    bowler,
    COUNT(*) AS total_wickets
FROM deliveries_clean
WHERE is_wicket = 1
  AND dismissal_kind NOT IN (
      'run out',
      'retired hurt',
      'obstructing the field'
  )
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;


-- 8. Most Player of the Match awards
SELECT
    player_of_match,
    COUNT(*) AS total_awards
FROM matches_clean
WHERE player_of_match IS NOT NULL
GROUP BY player_of_match
ORDER BY total_awards DESC
LIMIT 10;


-- 9. Toss winner vs match winner analysis
SELECT
    CASE
        WHEN toss_winner = winner THEN 'Toss Winner Won Match'
        ELSE 'Toss Winner Lost Match'
    END AS toss_result,
    COUNT(*) AS total_matches
FROM matches_clean
WHERE winner IS NOT NULL
GROUP BY toss_result
ORDER BY total_matches DESC;


-- 10. Top 10 IPL venues by matches hosted
SELECT
    venue,
    COUNT(*) AS total_matches
FROM matches_clean
GROUP BY venue
ORDER BY total_matches DESC
LIMIT 10;


-- 11. Season-wise IPL match count
SELECT
    season_year,
    COUNT(*) AS total_matches
FROM matches_clean
GROUP BY season_year
ORDER BY season_year;


-- 12. Team-wise win percentage
SELECT
    winner AS team,
    COUNT(*) AS total_wins,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM matches_clean WHERE winner IS NOT NULL),
        2
    ) AS win_percentage
FROM matches_clean
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC;


-- 13. Teams that won the most tosses
SELECT
    toss_winner AS team,
    COUNT(*) AS toss_wins
FROM matches_clean
WHERE toss_winner IS NOT NULL
GROUP BY toss_winner
ORDER BY toss_wins DESC
LIMIT 10;


-- 14. Matches won by batting first vs chasing
SELECT
    result,
    COUNT(*) AS total_matches
FROM matches_clean
WHERE result IS NOT NULL
GROUP BY result
ORDER BY total_matches DESC;


-- 15. Most sixes by batsmen
SELECT
    batter,
    COUNT(*) AS total_sixes
FROM deliveries_clean
WHERE batsman_runs = 6
GROUP BY batter
ORDER BY total_sixes DESC
LIMIT 10;


-- 16. Most fours by batsmen
SELECT
    batter,
    COUNT(*) AS total_fours
FROM deliveries_clean
WHERE batsman_runs = 4
GROUP BY batter
ORDER BY total_fours DESC
LIMIT 10;