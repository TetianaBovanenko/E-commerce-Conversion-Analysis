WITH page_user_sessions AS (
  SELECT
    SUBSTR(REGEXP_EXTRACT((SELECT value.string_value FROM UNNEST (event_params) WHERE key = 'page_location'), r'://(?:[^/]+)(/[^?#]*)'), 2) AS page_path,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) as user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    _TABLE_SUFFIX BETWEEN '20200101' AND '20201231'
),

page_session_start AS (
  SELECT
    SUBSTR(REGEXP_EXTRACT((SELECT value.string_value FROM UNNEST (event_params) WHERE key = 'page_location'), r'://(?:[^/]+)(/[^?#]*)'), 2) AS page_path,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) AS user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    event_name = 'session_start' AND
    _TABLE_SUFFIX BETWEEN '20200101' AND '20201231'
),

page_purchase AS (
  SELECT
    SUBSTR(REGEXP_EXTRACT((SELECT value.string_value FROM UNNEST (event_params) WHERE key = 'page_location'), r'://(?:[^/]+)(/[^?#]*)'), 2) AS page_path,
    CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) AS user_sessions
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    event_name = 'purchase' AND
    _TABLE_SUFFIX BETWEEN '20200101' AND '20201231'
)

SELECT
  pus.page_path,
  COUNT(DISTINCT(pus.user_sessions)) AS user_sessions_count,
  COUNT(DISTINCT(pp.user_sessions)) AS purchase,
  CASE
    WHEN COUNT(DISTINCT(pss.user_sessions))!= 0 THEN COUNT(DISTINCT(pp.user_sessions)) / COUNT(DISTINCT(pss.user_sessions))
  END AS visit_to_purchase
FROM
  page_user_sessions AS pus
LEFT JOIN page_session_start AS pss USING(user_sessions)
LEFT JOIN page_purchase AS pp USING(user_sessions)
GROUP BY
  1
ORDER BY
  1
