#!/bin/bash

# confirmed: this script works when run manually as root user from root top directory using the following command
# sh ./config-linux.sh -u <username> -p <password> -h admin -i admin -j 98107 -k usa -l seattle -m data -n tech -o yes -q pm -r 8888888 -s tableau -t wa -v dev -w jamie -x jdata@tableau.com
# customized to reflect machine admin username and admin password

while getopts u:p:h:i:j:k:l:m:n:o:q:r:s:t:v:w:x: option
do
 case "${option}"
 in
 u) USER=${OPTARG};;
 p) PASSWORD=${OPTARG};;
 h) TS_USER=${OPTARG};;
 i) TS_PASS=${OPTARG};;
 j) ZIP=${OPTARG};;
 k) COUNTRY=${OPTARG};;
 l) CITY=${OPTARG};;
 m) LAST_NAME=${OPTARG};;
 n) INDUSTRY=${OPTARG};;
 o) EULA=${OPTARG};;
 q) TITLE=${OPTARG};;
 r) PHONE=${OPTARG};;
 s) COMPANY=${OPTARG};;
 t) STATE=${OPTARG};;
 v) DEPARMENT=${OPTARG};;
 w) FIRST_NAME=${OPTARG};;
 x) EMAIL=${OPTARG};;
esac
done

cd /tmp/

# create secrets
# took out -e after echo
echo "tsm_admin_user=\"$USER\"\ntsm_admin_pass=\"$PASSWORD\"\ntableau_server_admin_user=\"$TS_USER\"\ntableau_server_admin_pass=\"$TS_PASS\"" >> secrets

# create registration file
echo "{
 \"zip\" : \"$ZIP\",
 \"country\" : \"$COUNTRY\",
 \"city\" : \"$CITY\",
 \"last_name\" : \"$LAST_NAME\",
 \"industry\" : \"$INDUSTRY\",
 \"eula\" : \"$EULA\",
 \"title\" : \"$TITLE\",
 \"phone\" : \"$PHONE\",
 \"company\" : \"$COMPANY\",
 \"state\" : \"$STATE\",
 \"department\" : \"$DEPARMENT\",
 \"first_name\" : \"$FIRST_NAME\",
 \"email\" : \"$EMAIL\"
}" >> registration.json

# create config file
echo '{
  "configEntities": {
    "identityStore": {
      "_type": "identityStoreType",
      "type": "local"
    }
  }
}' >> config.json
wait

echo "created all files" >> installer_log.txt

# download tableau server .deb file
wget --output-document=tableau-installer.deb https://downloads.tableau.com/esdalt/2018.2.0/tableau-server-2018-2-0_amd64.deb

echo "downloaded server" >> installer_log.txt

# download automated-installer
wget --remote-encoding=UTF-8 --output-document=automated-installer.sh https://raw.githubusercontent.com/tableau/server-install-script-samples/master/linux/automated-installer/automated-installer

echo "downloaded automated-installer" >> installer_log.txt

#cd ..
wait
chmod +x automated-installer.sh

echo "modified automated-installer" >> installer_log.txt

# ensure everything is finished
wait

## ADD USER TO THIS
sudo ./automated-installer.sh -s secrets -f config.json -r registration.json -a "$USER" --accepteula tableau-installer.deb --force
# so it works from mcorneli...

echo "ran automated-installer" >> installer_log.txt

wait
## remove all install files
rm registration.json
rm secrets
rm tableau-installer.deb
rm automated-installer.sh
rm config.json

echo "removed all files" >> installer_log.txt