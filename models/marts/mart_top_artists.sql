with tracks as (
    select * from {{ ref('stg_tracks') }}
),

artists as (
    select * from {{ ref('stg_artists') }}
),

joined as (
    select
        t.track_id,
        t.track_name,
        t.popularity                    as track_popularity,
        t.duration_minutes,
        t.is_explicit,
        t.artist_names,
        t.danceability,
        t.energy,
        t.valence,
        t.tempo,
        a.artist_id,
        a.artist_name,
        a.followers,
        a.popularity                    as artist_popularity,
        a.genres

    from tracks t
    left join artists a
        on t.artist_ids = a.artist_id
),

top_artists as (
    select
        artist_name,
        artist_popularity,
        followers,
        genres,
        count(track_id)                 as total_tracks,
        round(avg(track_popularity), 2) as avg_track_popularity,
        round(avg(danceability), 2)     as avg_danceability,
        round(avg(energy), 2)           as avg_energy,
        round(avg(valence), 2)          as avg_valence,
        round(avg(tempo), 2)            as avg_tempo,
        sum(case when is_explicit then 1 else 0 end) as explicit_tracks

    from joined
    where artist_name is not null
    group by
        artist_name,
        artist_popularity,
        followers,
        genres
    order by artist_popularity desc
)

select * from top_artists