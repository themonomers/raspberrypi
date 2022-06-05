#!/bin/bash

. "$(dirname "$0")/backup_config.ini"

fetch_fields() {
  curl -sSL -f -k -H "Authorization: Bearer ${1}" "${HOST}/api/${2}" | jq -r "if type==\"array\" then .[] else . end| .${3}"
}

# loop through each Grafana org
for row in "${ORGS[@]}" ; do
  ORG=${row%%:*}
  KEY=${row#*:}
  DIR="$FILE_DIR/$ORG"

  # append timestamp to directory
  timestamp=$(date +"%Y.%m.%d.%H.%M.%S")
  DIR=$DIR-$timestamp

  mkdir -p "$DIR/dashboards"
  mkdir -p "$DIR/datasources"
  mkdir -p "$DIR/alert-notifications"
  mkdir -p "$DIR/alerts"
  mkdir -p "$DIR/playlists"

  # loop through each dashboard (filter out folders) and export
  for uid in $(curl -sSL -f -k -H "Authorization: Bearer ${KEY}" "${HOST}/api/search?query=&" | jq -r '.[] | select(.type=="dash-db") | .uid'); do
    uri=$(curl -sSL -f -k -H "Authorization: Bearer ${KEY}" "${HOST}/api/search?query=&" | jq -r ".[] | select(.uid==""\"${uid}""\") | .uri")
    DB=$(echo ${uri}|sed 's,db/,,g').json
    echo $DB

    curl -f -k -H "Authorization: Bearer ${KEY}" "${HOST}/api/dashboards/uid/${uid}" | jq 'del(.overwrite,.dashboard.version,.meta.created,.meta.createdBy,.meta.updated,.meta.updatedBy,.meta.expires,.meta.version)' > "$DIR/dashboards/${DB}"
  done

  # loop through each data source and export
  for id in $(fetch_fields $KEY 'datasources' 'id'); do
    DS=$(echo $(fetch_fields $KEY "datasources/${id}" 'name')|sed 's/ /-/g').json
    echo $DS

    curl -f -k -H "Authorization: Bearer ${KEY}" "${HOST}/api/datasources/${id}" | jq '' > "$DIR/datasources/${DS}"
  done

  # loop through each notification channel and export
  for id in $(fetch_fields $KEY 'alert-notifications' 'id'); do
    AN=$(echo $(fetch_fields $KEY "alert-notifications/${id}" 'name')|sed 's/ /-/g').json
    echo $AN

    curl -f -k -H "Authorization: Bearer ${KEY}" "${HOST}/api/alert-notifications/${id}" | jq 'del(.created,.updated)' > "$DIR/alert-notifications/$AN"
  done

  # loop through each alert and export
  for id in $(fetch_fields $KEY 'alerts' 'id'); do
    AL=$(echo $(fetch_fields $KEY "alerts/${id}" 'Name')|sed 's/ /-/g').json
    echo $AL

    curl -f -k -H "Authorization: Bearer ${KEY}" "${HOST}/api/alerts/${id}" | jq 'del(.created,.updated)' > "$DIR/alerts/$AL"
  done

  # loop through each playlist and export
  for id in $(fetch_fields $KEY 'playlists' 'id'); do
    PL=$(echo $(fetch_fields $KEY "playlists/${id}" 'name')|sed 's/ /-/g').json
    echo $PL

    curl -f -k -H "Authorization: Bearer ${KEY}" "${HOST}/api/playlists/${id}" | jq 'del(.created,.updated)' > "$DIR/playlists/$PL"
  done
done

# delete all but the last 5 backups
ls -t -d /home/pi/grafana/org1-* | tail -n +6 | xargs rm -rf


# alternative backup
echo "Executing alternative Grafana backup"
sudo tar -cvf /home/pi/grafana/grafana-$timestamp.tar /var/lib/grafana/grafana.db
sudo tar -rvf /home/pi/grafana/grafana-$timestamp.tar /etc/grafana/grafana.ini
gzip /home/pi/grafana/grafana-$timestamp.tar

# delete all but the last 5 backups
ls -t -d /home/pi/grafana/grafana-* | tail -n +6 | xargs rm -rf


# backup the backups to usb drive
rsync -a --delete /home/pi/grafana /mnt/usb
