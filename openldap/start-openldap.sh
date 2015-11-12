#!/bin/env bash

if [ -f openldap_configured.txt ];
then
   echo "OpenLDAP was already configured, starting it."
   /usr/local/libexec/slapd -d
else
   echo "OpenLDAP was not yet configured. Doing it now and then starting it."
   /usr/local/libexec/slapd
   sleep 5
   ldapadd -x -w $LDAP_ROOT_PASSWORD -D "cn=LayersManager,dc=learning-layers,dc=eu" -f /usr/local/etc/openldap/ldap-init.ldif
   pkill slapd
   echo 'OpenLDAP' > openldap_configured.txt
   /usr/local/libexec/slapd -d 8
fi
