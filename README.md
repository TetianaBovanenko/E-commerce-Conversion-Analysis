# E-commerce Conversion Analysis

Technology Stack:
BigQuery (CTE, regular expressions, data aggregation, function, joins)

Project Description:
This project involves the analysis of conversion data from a publicly available dataset collected using Google Analytics 4 (GA4), specifically from the Google online store. The objective was to extract insights by examining session start events and subsequent purchases to calculate various key metrics.

To accomplish this, I extracted page paths (the path to the page without domain addresses and link parameters) from the session start events.

For each unique session start page, I calculated the following 2020-based metrics:

- The number of unique sessions among distinct users.
- The number of purchases.
- The conversion rate from session start to purchase.

  
Since session start and purchase events can have different URLs, I merged them using user IDs and session IDs for accurate analysis.

[BigQuery Link ](https://console.cloud.google.com/bigquery?sq=916069414937:a9cbf36489684530aafcc282f37fcde6&project=bigquery-project-429212&ws=!1m7!1m6!12m5!1m3!1sbigquery-project-429212!2sus-central1!3s5c04a07e-c3a8-4658-a46d-8d9f7ede5acd!2e1)

[GA4 Data Link](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=ga4_obfuscated_sample_ecommerce&t=events_20210131&page=table&project=hardy-scarab-392910&ws=!1m5!1m4!4m3!1sbigquery-public-data!2sga4_obfuscated_sample_ecommerce!3sevents_20210131)


Skills:
Data Analysis · SQL · Google BigQuery · Google Analytics 4 · Big Data · Big Data Analytics 
