token=`cat ~/.toggl_token`
url="https://toggl.com/reports/api/v2/details?workspace_id=777508&user_agent=i1shi4ga4mi1@gmail.com"
curl $url -u $token:api_token | jq . -M > response.json
