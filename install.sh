#!/bin/bash
cd /tmp
curl -so wazuh-agent-4.2.5.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.2.5-1_amd64.deb && sudo WAZUH_MANAGER='wazuh-monitor.ddns.net' WAZUH_AGENT_GROUP='Linux,Server' dpkg -i ./wazuh-agent-4.2.5.deb

sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent


###########################Adding Ossec Conf################################
git clone https://github.com/amithalder21/wazuh-agent-ubuntu.git
cd wazuh-agent-ubuntu
cat ossec.conf >> /var/ossec/etc/ossec.conf

###########################Adding Virus scanner Script######################
mv remove-threat.sh /var/ossec/active-response/bin/remove-threat.sh
chmod 750 /var/ossec/active-response/bin/remove-threat.sh
chown root:ossec /var/ossec/active-response/bin/remove-threat.sh
