# Spotify dbt Pipeline

An end-to-end data transformation pipeline built with dbt, BigQuery,
and Looker Studio, analyzing 400,000+ Spotify tracks and 1.1M+ artists.

## Live Dashboard
📊 [Click here to view the interactive Spotify Analytics Dashboard](https://datastudio.google.com/u/2/reporting/a4ae0dbc-73d2-4105-a22d-0fbdb36415ee/page/f4b3F)

## Tech Stack
- **dbt Core** — data transformation and modeling
- **BigQuery** — cloud data warehouse (Google Cloud)
- **Looker Studio** — interactive dashboard and data visualization
- **SQL** — transformation logic
- **Python** — data preparation and sampling

## Pipeline Architecture

Raw Spotify Data (CSV)
↓
BigQuery (cloud warehouse)
↓
dbt Staging Models (clean + standardize)
↓
dbt Mart Models (business insights)
↓
Looker Studio Dashboard (visualize + explore)

## Models

### Staging
- `stg_tracks` — cleans raw track data, converts types,
  removes formatting artifacts, converts ms to minutes
- `stg_artists` — cleans raw artist data, standardizes types

### Marts
- `mart_top_artists` — joins tracks and artists, aggregates
  popularity metrics, follower counts, and audio features per artist
- `mart_audio_features` — categorizes songs by mood, energy level,
  tempo, and popularity bucket for business analysis

## Dashboard Features
- **Total Tracks Analyzed** — scorecard showing 369,453 tracks
- **Track Distribution by Popularity** — bar chart showing how tracks
  are distributed across popularity buckets
- **Top 10 Artists by Popularity** — bar chart of most popular artists
- **Avg Danceability by Popularity** — proves the danceability trend
- **Top 10 Most Popular Songs** — table with track name, artist, popularity
- **Interactive filters** — filter by energy level and mood

## Data Quality Tests
7 automated tests covering:
- Unique track IDs (no duplicates)
- Unique artist IDs (no duplicates)
- Not null checks on track name, track ID, popularity
- Not null checks on artist name, artist ID

## Key Transformations
- Converted duration from milliseconds to minutes
- Cleaned bracket/quote formatting from array columns using regex
- Cast all columns to correct data types (INT64, FLOAT64)
- Created business-friendly categories (mood, energy level,
  popularity bucket, tempo category)
- Filtered null records for data quality

## Key Findings
Analysis of 400,000 Spotify tracks revealed a clear pattern
between audio features and popularity:

| Popularity Bucket | Track Count | Avg Danceability | Avg Energy |
|---|---|---|---|
| Very Popular | 657 | 0.68 | 0.64 |
| Popular | 18,319 | 0.63 | 0.64 |
| Moderate | 88,209 | 0.60 | 0.63 |
| Low | 149,666 | 0.57 | 0.57 |
| Very Low | 112,602 | 0.53 | 0.48 |

**Finding 1:** Only 657 out of 400,000 tracks (0.16%) qualify
as "Very Popular" — hitting the top tier is extremely rare.

**Finding 2:** Danceability and energy consistently increase
with popularity — the most popular songs score 28% higher
on danceability than the least popular ones.

**Finding 3:** Justin Bieber has the highest popularity score
(100) in the dataset, while Taylor Swift has the most tracks
(245) and Drake has the most followers (54.4M).

## Dataset
Spotify Tracks and Artists — Kaggle
- 400,000 tracks (sampled from 586,672)
- 1,104,349 artists

## Author
Deepti Dhanapala — Data Scientist
[LinkedIn](https://linkedin.com/in/deeptidhanpal) |
[GitHub](https://github.com/Deepti-Dhanapala)
