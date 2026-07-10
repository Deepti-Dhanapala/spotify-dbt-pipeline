with source as (
    select * from {{ source('raw', 'artists') }}
),

cleaned as (
    select
        id                                          as artist_id,
        name                                        as artist_name,
        cast(popularity as INT64)                   as popularity,
        cast(followers as FLOAT64)                  as followers,
        regexp_replace(genres, r"[\[\]']", '')      as genres

    from source
    where id is not null
      and name is not null
)

select * from cleaned