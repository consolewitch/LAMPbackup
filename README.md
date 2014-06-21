LAMPbackup
==========

A linux shell and perl script for backing up LAMP services to a local folder. 

This script is intended to make local snapshots of your LAMP server.  This will not protect you if you have a failure of your drive array or
some other awful thing.  It does make it easier to recover a borked database or a accidentally rm -rf'd web root.

the shell script should go in your /etc/cron.d/
the perl script should go in your /usr/sbin/
you'll need to edit your crontab to make sure it is calling the shell script when you want it to.
