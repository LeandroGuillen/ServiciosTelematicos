#!/bin/bash
echo "Comprobando conectividad y resolucion de nombres:"
echo "*host www" &&\
host www &&\
echo "*host www.st.um" &&\
host www.st.um &&\
echo "*host www.google.es" &&\
host www.google.es

echo "Comprobando funcionalidad LDAP:"
ldapsearch -x  -b "o=um,c=es" correo -H ldap://ldap.st.um