#!/bin/bash

###########################Adding Agent#####################################
cd $(pwd)
curl -so wazuh-agent-4.2.5.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.2.5-1_amd64.deb && sudo WAZUH_MANAGER='wazuh-monitor.ddns.net' WAZUH_AGENT_GROUP='Linux,Server' dpkg -i ./wazuh-agent-4.2.5.deb
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent


###########################Adding Virus scanner Integration################
cat ossec.conf >> /var/ossec/etc/ossec.conf
mv remove-threat.sh /var/ossec/active-response/bin/remove-threat.sh
chmod 750 /var/ossec/active-response/bin/remove-threat.sh
chown root:ossec /var/ossec/active-response/bin/remove-threat.sh
apt install jq -y
sudo systemctl restart wazuh-agent
