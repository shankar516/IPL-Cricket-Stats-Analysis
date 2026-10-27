# IPL Cricket Statistics Analysis Dashboard

## Project Overview
This project analyzes Indian Premier League (IPL) match-level and ball-by-ball cricket data to identify team performance, top batsmen, leading bowlers, toss impact, and venue trends.

## Tools Used
- Python
- Pandas
- NumPy
- Matplotlib
- MySQL
- Power BI
- Excel / CSV

## Dataset
The project uses two IPL datasets:

- `matches.csv` — match-level information such as teams, venue, toss winner, match winner, season, and Player of the Match.
- `deliveries.csv` — ball-by-ball data including batter, bowler, runs, extras, and wickets.

## Key Analysis Performed
- Team-wise total wins
- Top 10 run scorers
- Top 10 wicket takers
- Toss winner versus match winner analysis
- Venue-wise match count
- Season-wise match analysis
- Player of the Match trends
- Most fours and sixes

## Key Insights
- Mumbai Indians recorded the highest number of total wins in the dataset.
- Virat Kohli is the highest run scorer with 8,014 runs.
- Yuzvendra Chahal is the leading wicket taker with 205 wickets.
- Toss winners won 554 matches, while toss winners lost 536 matches, showing only a small toss advantage.
- Eden Gardens is among the most frequently used IPL venues.

## Project Structure  

```text
IPL-Cricket-Stats-Analysis/
│
├── data/
│   ├── matches.csv
│   ├── deliveries.csv
│   ├── matches_clean.csv
│   ├── deliveries_clean.csv
│   ├── team_wins.csv
│   ├── top_batsmen.csv
│   ├── top_bowlers.csv
│   ├── toss_analysis.csv
│   └── venue_matches.csv
│
├── notebooks/
│   └── ipl_analysis.ipynb
│
├── sql/
│   └── ipl_queries.sql
│
├── dashboard/
│   └── IPL_Cricket_Stats_Dashboard.pbix
│
├── images/
├── README.md
├── requirements.txt
└── import_to_mysql.py
