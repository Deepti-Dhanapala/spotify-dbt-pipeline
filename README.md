# Spotify dbt Pipeline

An end-to-end data transformation pipeline built with dbt and BigQuery,
analyzing 400,000+ Spotify tracks and 1.1M+ artists.

## Tech Stack
- **dbt** — data transformation and modeling
- **BigQuery** — cloud data warehouse
- **SQL** — transformation logic
- **Python** — data preparation

## Pipeline Architecture
Raw Spotify Data → Staging Models → Mart Models → Analysis Ready

## Models

### Staging
- `stg_tracks` — cleans and standardizes raw track data
- `stg_artists` — cleans and standardizes raw artist data

### Marts
- `mart_top_artists` — joins tracks and artists,
   aggregates popularity metrics per artist
- `mart_audio_features` — categorizes songs by mood,
   energy level, tempo, and popularity bucket

## Data Quality Tests
7 automated tests covering:
- Unique track and artist IDs
- Not null checks on critical columns

## Key Transformations
- Converted duration from milliseconds to minutes
- Cleaned bracket/quote formatting from array columns
- Cast all columns to correct data types
- Created business-friendly categories
  (mood, energy level, popularity bucket)
