with tracks as (
    select * from {{ ref('stg_tracks') }}
),

audio_analysis as (
    select
        track_name,
        artist_names,
        popularity,
        duration_minutes,
        is_explicit,
        danceability,
        energy,
        valence,
        tempo,
        acousticness,
        instrumentalness,
        speechiness,
        liveness,
        loudness,

        -- Popularity buckets
        case
            when popularity >= 80 then 'Very Popular'
            when popularity >= 60 then 'Popular'
            when popularity >= 40 then 'Moderate'
            when popularity >= 20 then 'Low'
            else 'Very Low'
        end as popularity_bucket,

        -- Energy level
        case
            when energy >= 0.8 then 'High Energy'
            when energy >= 0.5 then 'Medium Energy'
            else 'Low Energy'
        end as energy_level,

        -- Mood based on valence
        case
            when valence >= 0.7 then 'Happy'
            when valence >= 0.4 then 'Neutral'
            else 'Sad'
        end as mood,

        -- Tempo category
        case
            when tempo >= 120 then 'Fast'
            when tempo >= 90 then 'Medium'
            else 'Slow'
        end as tempo_category

    from tracks
    where popularity > 0
)

select * from audio_analysis
order by popularity desc