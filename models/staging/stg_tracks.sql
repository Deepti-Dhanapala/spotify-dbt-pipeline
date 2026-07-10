with source as (
    select * from {{ source('raw', 'tracks') }}
),

cleaned as (
    select
        id                                              as track_id,
        name                                            as track_name,
        cast(popularity as INT64)                       as popularity,
        cast(duration_ms as INT64)                      as duration_ms,
        round(cast(duration_ms as INT64) / 60000, 2)   as duration_minutes,
        case 
            when cast(explicit as INT64) = 1 then true
            else false 
        end                                             as is_explicit,
        regexp_replace(artists, r"[\[\]']", '')         as artist_names,
        regexp_replace(id_artists, r"[\[\]']", '')      as artist_ids,
        release_date,
        cast(danceability as FLOAT64)                   as danceability,
        cast(energy as FLOAT64)                         as energy,
        cast(loudness as FLOAT64)                       as loudness,
        cast(speechiness as FLOAT64)                    as speechiness,
        cast(acousticness as FLOAT64)                   as acousticness,
        cast(instrumentalness as FLOAT64)               as instrumentalness,
        cast(liveness as FLOAT64)                       as liveness,
        cast(valence as FLOAT64)                        as valence,
        cast(tempo as FLOAT64)                          as tempo,
        cast(key as INT64)                              as musical_key,
        cast(mode as INT64)                             as musical_mode,
        cast(time_signature as INT64)                   as time_signature

    from source
    where id is not null
      and name is not null
)

select * from cleaned