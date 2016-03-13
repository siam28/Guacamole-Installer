# Guacamole-Installer
Guacamole Installer for Arch Linux

About Options
 * In this setup of Guacamole, I use the MySQL authentication backend
   It is also possible to make use of LDAP authentication, but this
   will require a more complex setup. Although I would recommend for Enterprise use.
 * Options of Guacamole are configured in /etc/guacamole. Please make you environment
   point to this directory, do this with setting GUACAMOLE_HOME=/etc/guacamole


This Installer is a beta one.
 * I made the installer while installing Guacamole version 0.9.7.0
 * You should make use of GUACAMOLE_HOME and point it to /etc/guacamole
   Read the Guacamole Installation Guide about guacamole.properties and Authentication etc.
 * Maybe for future use, I will make a installer that install / configure all guacamole components
   without any interaction. But for now, I share with you my installation of Guacamole on Arch Linux

 

If you are interested, there will be an installer soon, for install Guacamole on the Raspberry 2 / 3
I already have a working setup. It is very straight forwarded configuration as on Arch Linux.
And nginx will be used as reverse proxy, I love the setup I made for Arch Linux and keep using it.