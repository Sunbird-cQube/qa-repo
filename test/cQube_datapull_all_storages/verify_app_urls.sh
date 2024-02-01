#!/bin/bash


GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

config_file="config_files/config.yml"
app_url=$(grep 'api_endpoint' "$config_file" | awk '{print $2}')

url="https://$app_url/dashboard/#/summary-statistics"
endpoint="/api/ingestion"
api_url="https://$app_url"

echo "$app_url endpoint ::::  Application URL is : $url"

# Send a GET request and capture the HTTP response code
response_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

if [ "$response_code" -eq 200 ]; then
    echo -e "${GREEN}cQube Summary Statistics Page is Displayed. HTTP response code : $response_code. ${NC}"
else
    echo -e "${RED} URL $url is not working. HTTP response code : $response_code. ${NC}"
    break
fi


endpoint="$api_url$endpoint"
EXPECTED_RESPONSE="Hello World!!!"

response=$(curl -s "$endpoint")

if [[ "$response" == *"$EXPECTED_RESPONSE"* ]]; then
    echo -e "${GREEN}API responded with the expected content: $EXPECTED_RESPONSE . {NC}"
else
    echo -e "${RED}API did not respond with the expected content. {NC}"
    break
fi

