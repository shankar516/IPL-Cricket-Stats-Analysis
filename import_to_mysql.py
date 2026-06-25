import pandas as pd
import mysql.connector

# Read cleaned delivery CSV
deliveries = pd.read_csv("data/deliveries_clean.csv")

# Convert all missing values to Python None
deliveries = deliveries.astype(object)
deliveries = deliveries.where(pd.notnull(deliveries), None)

# Connect to MySQL
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="shankar1234",
    database="ipl_analysis"
)

cursor = connection.cursor()

# Delete incomplete table
cursor.execute("DROP TABLE IF EXISTS deliveries_clean")

# Create table
cursor.execute("""
CREATE TABLE deliveries_clean (
    match_id INT,
    inning INT,
    batting_team VARCHAR(100),
    bowling_team VARCHAR(100),
    over_no INT,
    ball INT,
    batter VARCHAR(100),
    bowler VARCHAR(100),
    non_striker VARCHAR(100),
    batsman_runs INT,
    extra_runs INT,
    total_runs INT,
    extras_type VARCHAR(100),
    is_wicket INT,
    player_dismissed VARCHAR(100),
    dismissal_kind VARCHAR(100),
    fielder VARCHAR(100)
)
""")

insert_query = """
INSERT INTO deliveries_clean (
    match_id, inning, batting_team, bowling_team, over_no, ball,
    batter, bowler, non_striker, batsman_runs, extra_runs, total_runs,
    extras_type, is_wicket, player_dismissed, dismissal_kind, fielder
)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

# Keep only required columns and rename "over" to "over_no"
selected_columns = [
    "match_id", "inning", "batting_team", "bowling_team",
    "over", "ball", "batter", "bowler", "non_striker",
    "batsman_runs", "extra_runs", "total_runs",
    "extras_type", "is_wicket", "player_dismissed",
    "dismissal_kind", "fielder"
]

data_to_insert = deliveries[selected_columns].copy()
data_to_insert = data_to_insert.rename(columns={"over": "over_no"})

# Final NaN-to-None conversion for every row
values = []
for row in data_to_insert.itertuples(index=False, name=None):
    clean_row = tuple(None if pd.isna(value) else value for value in row)
    values.append(clean_row)

# Insert in batches
batch_size = 5000

for start in range(0, len(values), batch_size):
    batch = values[start:start + batch_size]
    cursor.executemany(insert_query, batch)
    connection.commit()

    print(f"Inserted rows {start + 1} to {min(start + batch_size, len(values))}")

cursor.close()
connection.close()

print("Full deliveries dataset imported successfully!")