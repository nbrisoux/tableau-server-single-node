#!/bin/bash
#build this out to accept parameter inputs for registration

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

echo -e "tsm_admin_user=\"$USER\"\ntsm_admin_pass=\"$PASSWORD\"\ntableau_server_admin_user=\"$TS_USER\"\ntableau_server_admin_pass=\"$TS_PASS\"" >> secrets

# create secrets 
# echo -e "tsm_admin_user= $tsm_admin_user\ntsm_admin_pass= $tsm_admin_pass\ntableau_server_admin_user= $ts_user\ntableau_server_admin_pass= $ts_pass" >> secrets

# create registration file
echo "{
 \"zip\" : \"$ZIP\",
 \"country\" : \"$COUNTRY\",
 \"city\" : \"$CITY\",
 \"last_name\" : \"$LAST_NAME\",
 \"industry\" : \"$INDUSTRY\",
 \"eula\" : \"$EULA\",
 \"title\" : \"TITLE\",
 \"phone\" : \"PHONE\",
 \"company\" : \"COMPANY\",
 \"state\" : \"STATE\",
 \"department\" : \"DEPARMENT\",
 \"first_name\" : \"FIRST_NAME\",
 \"email\" : \"EMAIL\"
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
# download tableau server .deb file
wget --output-document=tableau-installer.deb https://downloads.tableau.com/esdalt/2018.1.1/tableau-server-2018-1-1_amd64.deb

# download automated-installer
wget --remote-encoding=UTF-8 --output-document=automated-installer.sh https://raw.githubusercontent.com/tableau/server-install-script-samples/master/linux/automated-installer/automated-installer

#cd ..
#sudo chown tsm_admin_user -R tabserv/
#cd tabserv
wait
chmod +x automated-installer.sh

# ensure everything is finished
wait

sudo ./automated-installer.sh -s secrets -f config.json -r registration.json -a mcorneli --accepteula tableau-installer.deb --force
# so it works from mcorneli...

wait
# remove all install files
rm registration.json
rm secrets
rm tableau-installer.deb
rm automated-installer.sh
rm config.json