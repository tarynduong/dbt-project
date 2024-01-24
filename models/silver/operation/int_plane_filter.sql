select * from {{ ref('stg_plane') }}
where issue_date is not null