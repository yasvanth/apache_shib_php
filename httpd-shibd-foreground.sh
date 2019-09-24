#!/bin/bash

###### Start Shibboleth
/etc/init.d/shibd start

##### Start Apache in foreground
exec apachectl -D FOREGROUND
