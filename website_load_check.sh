#!/bin/bash

# Website URL to check
WEBSITE_URL="http://mail-ship.com"

# Threshold for load time in seconds
LOAD_THRESHOLD=0.008

# Slack webhook URL for sending alerts
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"

# Get the load time of the website using cURL
# The `-o /dev/null` option discards the output, `-s` silences progress, 
# and `-w` is used to output only the time in seconds.
LOAD_TIME=$(curl -o /dev/null -s -w "%{time_total}\n" "$WEBSITE_URL")

# Compare the load time with the threshold
if (( $(echo "$LOAD_TIME > $LOAD_THRESHOLD" | bc -l) )); then
    # Prepare the Slack alert message
    ALERT_MESSAGE=":warning: *Alert*: The load time for $WEBSITE_URL is $LOAD_TIME seconds, exceeding the threshold of $LOAD_THRESHOLD seconds."

    # Send the alert to Slack using cURL
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$ALERT_MESSAGE\"}" \
        "$SLACK_WEBHOOK_URL"
else
    echo "Load time for $WEBSITE_URL is $LOAD_TIME seconds, which is within the acceptable threshold."
fi